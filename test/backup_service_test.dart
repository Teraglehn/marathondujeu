import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';

import 'isar_test_support.dart';

/// L09 — le fichier de sauvegarde : un événement complet fait l'aller-retour vers une base
/// vide sans rien perdre ; l'écriture suit les modifications après regroupement ; un fichier
/// déjà en base se remplace.
void main() {
  late Isar isar;
  late Directory dir;

  ({EventService events, DrawService draws, PlayerGroupService groups, BackupService backup}) services(Isar isar, {Duration? delay}) {
    final client = TestIsarClient(isar);
    return (
      events: EventService(SessionRepository(client), EventRepository(client), PlayerRepository(client), DrawWinnerRepository(client)),
      draws: DrawService(DrawRepository(client), DrawWinnerRepository(client), PlayerGroupRepository(client)),
      groups: PlayerGroupService(PlayerGroupRepository(client)),
      backup: BackupService(client, delay: delay ?? const Duration(milliseconds: 100), maxDelay: const Duration(milliseconds: 500)),
    );
  }

  setUpAll(() async {
    isar = await openTestIsar();
    dir = await Directory.systemTemp.createTemp('marathondujeu_backup_');
  });

  tearDownAll(() async {
    await isar.close(deleteFromDisk: true);
    await dir.delete(recursive: true);
  });

  setUp(() => isar.writeTxn(() => isar.clear()));

  /// Un événement avec tout : 6 joueurs, 4 sessions, badgeages, bonus, un groupe, un tirage
  /// effectué et une copie préparée, une image.
  Future<Event> fullEvent(Isar isar) async {
    final s = services(isar);
    final event = Event()
      ..name = 'Marathon complet'
      ..startDateTime = DateTime(2026, 10, 3, 14)
      ..endDateTime = DateTime(2026, 10, 3, 15)
      ..sessionTimeMinutes = 15
      ..sessionIntervalMinutes = 15
      ..qrSalt = 'abcd1234'
      ..playerCardBackgroundImage = [1, 2, 3, 4, 5]
      ..qrCodeBackgroundColor = 0xFFFF0000
      ..idFontSize = 20;
    await s.events.save(event);
    await s.events.generateMissingPlayers(event, 6);
    final players = await isar.players.where().sortByNumber().findAll();
    final sessions = await isar.sessions.where().sortByNumber().findAll();
    await s.events.badgeSession(sessions[0], players[0], manual: true);
    await s.events.badgeSession(sessions[0], players[1], manual: true);
    await s.events.badgeSession(sessions[2], players[0], manual: true);
    players[3].bonusSession = 2;
    await isar.writeTxn(() => isar.players.put(players[3]));

    final group = PlayerGroup()..name = 'Habitués'..event.value = event;
    await s.groups.save(group);
    await s.groups.addPlayer(group, players[0]);
    await s.groups.addPlayer(group, players[3]);

    final draw = await s.draws.createDraw(event);
    draw
      ..name = 'Tirage 1'
      ..winnerCount = 2
      ..minSessionNumber = 1
      ..requiredSessions.clear()
      ..requiredSessions.add(sessions[0])
      ..excludedPlayers.add(players[5]);
    await s.draws.launch(draw);
    final copy = await s.draws.createDrawFromDraw(draw);
    await s.draws.save(copy);
    return (await isar.events.get(event.id))!;
  }

  group('format', () {
    test('un fichier illisible est refusé sans rien écrire', () {
      expect(() => BackupFormat.decode('pas du json'), throwsA(isA<BackupFormatException>()));
      expect(() => BackupFormat.decode('{"format": 99}'), throwsA(isA<BackupFormatException>()));
      expect(() => BackupFormat.decode('{"format": 1, "event": {}}'), throwsA(isA<BackupFormatException>()));
    });

    test('le fichier ne porte ni id Isar ni chemin de sauvegarde', () async {
      final event = await fullEvent(isar);
      event.backupPath = 'C:\\quelque part';
      final text = BackupFormat.encode(await BackupService.snapshot(isar, event));
      final json = jsonDecode(text) as Map<String, dynamic>;
      expect(json['format'], 1);
      expect(text, isNot(contains('backupPath')));
      expect((json['event'] as Map).containsKey('id'), isFalse);
      expect((json['players'] as List).length, 6);
      expect((json['sessions'] as List)[0]['players'], [1, 2]);
      expect((json['draws'] as List)[0]['winners'], hasLength(2));
    });
  });

  group('aller-retour', () {
    test('ouvert dans une base vide : tout est là', () async {
      final source = await fullEvent(isar);
      final text = BackupFormat.encode(await BackupService.snapshot(isar, source));
      final sourceWinners = (await isar.drawWinners.where().findAll())..sort((a, b) => a.position.compareTo(b.position));
      for (final w in sourceWinners) {
        await w.winner.load();
      }
      final winnerNumbers = sourceWinners.map((w) => w.winner.value!.number).toList();

      final other = await openTestIsar();
      addTearDown(() => other.close(deleteFromDisk: true));
      final s = services(other);
      final opening = await s.backup.open(await (File('${dir.path}/rt.json')..writeAsStringSync(text)).resolveSymbolicLinks());
      expect(opening.existing, isNull);
      final event = await s.backup.import(opening.backup);

      expect(event.uid, source.uid);
      expect(event.name, 'Marathon complet');
      expect(event.qrSalt, 'abcd1234');
      expect(event.playerCardBackgroundImage, [1, 2, 3, 4, 5]);
      expect(event.qrCodeBackgroundColor, 0xFFFF0000);
      expect(event.idFontSize, 20);
      expect(event.backupPath, isNull, reason: 'le chemin ne voyage pas');

      final players = await other.players.where().sortByNumber().findAll();
      expect(players.map((p) => p.number), [1, 2, 3, 4, 5, 6]);
      expect(players.map((p) => p.qrcode), (await isar.players.where().sortByNumber().findAll()).map((p) => p.qrcode));
      expect(players[3].bonusSession, 2);
      for (final p in players) {
        await p.event.load();
        expect(p.event.value?.id, event.id);
      }

      final sessions = await other.sessions.where().sortByNumber().findAll();
      expect(sessions.length, 4);
      expect(sessions[0].startTime, DateTime(2026, 10, 3, 14));
      await sessions[0].players.load();
      await sessions[2].players.load();
      expect(sessions[0].players.map((p) => p.number).toSet(), {1, 2});
      expect(sessions[2].players.map((p) => p.number).toSet(), {1});
      expect(players[0].getSessionNumber(), 2);
      expect(players[3].getTokenCount(), 2);

      final groups = await other.playerGroups.where().findAll();
      final manual = groups.firstWhere((g) => g.kind == PlayerGroupKind.manual);
      await manual.players.load();
      expect(manual.name, 'Habitués');
      expect(manual.players.map((p) => p.number).toSet(), {1, 4});
      final winnersGroup = groups.firstWhere((g) => g.kind == PlayerGroupKind.winners);
      await winnersGroup.players.load();
      expect(winnersGroup.players.map((p) => p.number).toSet(), winnerNumbers.toSet());

      final draws = await other.draws.where().findAll();
      final drawn = draws.firstWhere((d) => d.name == 'Tirage 1');
      final copy = draws.firstWhere((d) => d.name != 'Tirage 1');
      expect(drawn.drawnAt, isNotNull);
      expect(drawn.winnerCount, 2);
      await Future.wait([drawn.requiredSessions.load(), drawn.excludedPlayers.load(), drawn.winners.load(), drawn.winnersGroup.load()]);
      expect(drawn.requiredSessions.map((s) => s.number), [1]);
      expect(drawn.excludedPlayers.map((p) => p.number), [6]);
      expect(drawn.winnersGroup.value?.id, winnersGroup.id);
      final winners = drawn.winners.toList()..sort((a, b) => a.position.compareTo(b.position));
      for (final w in winners) {
        await w.winner.load();
      }
      expect(winners.map((w) => w.winner.value!.number).toList(), winnerNumbers);
      expect(copy.isDrawn, isFalse);
      await copy.excludedGroups.load();
      expect(copy.excludedGroups.map((g) => g.id), [winnersGroup.id], reason: 'la copie exclut les gagnants');
    });

    test('même uid en base : trouvé, puis remplacé en une fois', () async {
      final source = await fullEvent(isar);
      source.backupPath = '${dir.path}/replace.json';
      await isar.writeTxn(() => isar.events.put(source));
      final s = services(isar);
      await s.backup.writeEvent(isar, source);

      // La base change après l'écriture : un joueur de plus, un badgeage de plus.
      await s.events.generateMissingPlayers(source, 7);
      final opening = await s.backup.open(source.backupPath!);
      expect(opening.existing?.id, source.id);

      final event = await s.backup.import(opening.backup, replace: opening.existing);
      expect(event.uid, source.uid);
      expect(event.backupPath, source.backupPath, reason: 'un événement remplacé garde son fichier');
      expect(await isar.events.count(), 1);
      expect(await isar.players.count(), 6, reason: 'le septième joueur, postérieur au fichier, disparaît');
      expect(await isar.sessions.count(), 4);
      expect(await isar.draws.count(), 2);
      expect(await isar.drawWinners.count(), 2);
      expect(await isar.playerGroups.count(), 2);
    });
  });

  group('écriture automatique', () {
    test('dix modifications rapprochées → une écriture, après le délai', () async {
      final event = await fullEvent(isar);
      final path = '${dir.path}/auto.json';
      event.backupPath = path;
      await isar.writeTxn(() => isar.events.put(event));
      final s = services(isar);
      await s.backup.start();
      addTearDown(s.backup.dispose);

      final players = await isar.players.where().findAll();
      final file = File(path);
      var writes = 0;
      file.parent.watch().listen((e) { if (e.path.endsWith('auto.json') && e is! FileSystemDeleteEvent) writes++; });
      for (var i = 0; i < 10; i++) {
        players[0].bonusSession = i;
        await isar.writeTxn(() => isar.players.put(players[0]));
      }
      expect(s.backup.pending, isTrue);
      await Future.delayed(const Duration(milliseconds: 400));
      expect(s.backup.pending, isFalse);
      expect(file.existsSync(), isTrue);
      final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      expect((json['players'] as List).firstWhere((p) => p['number'] == players[0].number)['bonusSession'], 9);
      expect(s.backup.lastWrittenAt[event.id], isNotNull);
      expect(writes, lessThanOrEqualTo(2), reason: 'une écriture (.tmp renommé), pas dix');
    });

    test('flush écrit tout de suite ce qui est en attente', () async {
      final event = await fullEvent(isar);
      event.backupPath = '${dir.path}/flush.json';
      await isar.writeTxn(() => isar.events.put(event));
      final s = services(isar, delay: const Duration(seconds: 30));
      s.backup.changed();
      expect(s.backup.pending, isTrue);
      await s.backup.flush();
      expect(s.backup.pending, isFalse);
      expect(File(event.backupPath!).existsSync(), isTrue);
    });

    test('un dossier disparu → l\'erreur est signalée, rien ne casse', () async {
      final event = await fullEvent(isar);
      event.backupPath = '${dir.path}/nulle-part/x.json';
      await isar.writeTxn(() => isar.events.put(event));
      final s = services(isar);
      BackupWriteError? error;
      s.backup.onError = (e) => error = e;
      await s.backup.flush();
      expect(error?.event.id, event.id);
    });
  });
}
