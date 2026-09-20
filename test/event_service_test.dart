import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/src/data/isar_client.dart';

import 'isar_test_support.dart';

void main() {
  late Isar isar;
  late Event event;
  late Session s1, s2;
  late Player p1;

  EventService service() {
    final client = TestIsarClient(isar);
    return EventService(SessionRepository(client), EventRepository(client), PlayerRepository(client), DrawWinnerRepository(client));
  }

  Session session(int number) => Session()
    ..number = number
    ..startTime = DateTime(2026, 10, 3, 10 + number)
    ..endTime = DateTime(2026, 10, 3, 10 + number, 15)
    ..event.value = event;

  setUpAll(() async {
    isar = await openTestIsar();
  });

  tearDownAll(() => isar.close(deleteFromDisk: true));

  /// Un événement, deux sessions ; p1 badge s1 seulement.
  setUp(() async {
    await isar.writeTxn(() => isar.clear());
    event = Event()..name = 'Test';
    s1 = session(1);
    s2 = session(2);
    p1 = Player()
      ..name = '1'
      ..qrcode = '1'
      ..event.value = event;
    await isar.writeTxn(() async {
      await isar.events.put(event);
      await isar.sessions.putAll([s1, s2]);
      await isar.players.put(p1);
      await s1.event.save();
      await s2.event.save();
      await p1.event.save();
      s1.players.add(p1);
      await s1.players.save();
    });
  });

  Future<Set<int>> badgedSessions() async {
    final player = await isar.players.get(p1.id);
    await player!.sessions.load();
    return player.sessions.map((s) => s.id).toSet();
  }

  group('destroyEvent', () {
    test('ferme un événement : lui et tout ce qui s\'y rattache, rien d\'autre', () async {
      // Un second événement, avec les mêmes sortes de données, qui doit rester intact.
      final other = Event()..name = 'Autre';
      final os = Session()..number = 1..startTime = DateTime(2026, 10, 4, 10)..endTime = DateTime(2026, 10, 4, 11)..event.value = other;
      final op = Player()..name = '9'..qrcode = '9'..number = 9..event.value = other;
      final og = PlayerGroup()..name = 'og'..event.value = other;
      final od = Draw.empty()..name = 'od'..event.value = other;
      final ow = DrawWinner()..position = 1..draw.value = od..winner.value = op;
      final g = PlayerGroup()..name = 'g'..event.value = event;
      final d = Draw.empty()..name = 'd'..event.value = event;
      final w = DrawWinner()..position = 1..draw.value = d..winner.value = p1;
      await isar.writeTxn(() async {
        await isar.events.put(other);
        await isar.sessions.put(os);
        await isar.players.put(op);
        await isar.playerGroups.putAll([og, g]);
        await isar.draws.putAll([od, d]);
        await isar.drawWinners.putAll([ow, w]);
        for (final l in [os.event, op.event, og.event, od.event, ow.draw, ow.winner, g.event, d.event, w.draw, w.winner]) {
          await l.save();
        }
      });

      await service().destroyEvent(event);

      expect(await isar.events.count(), 1);
      expect((await isar.events.where().findFirst())!.name, 'Autre');
      expect(await isar.players.count(), 1);
      expect(await isar.sessions.count(), 1);
      expect(await isar.playerGroups.count(), 1);
      expect(await isar.draws.count(), 1);
      expect(await isar.drawWinners.count(), 1);
    });
  });

  group('sessionStarts', () {
    final start = DateTime(2026, 10, 3, 14);

    test('toutes les [intervalle] minutes, tant qu\'on est avant la fin', () {
      final starts = EventService.sessionStarts(start, DateTime(2026, 10, 3, 17), 15);
      expect(starts.length, 12);
      expect(starts.first, start);
      expect(starts[1], DateTime(2026, 10, 3, 14, 15));
      expect(starts.last, DateTime(2026, 10, 3, 16, 45));
    });

    test('la fin exclue : une session qui commencerait à la fin n\'existe pas', () {
      expect(EventService.sessionStarts(start, DateTime(2026, 10, 3, 14, 30), 15).length, 2);
      expect(EventService.sessionStarts(start, DateTime(2026, 10, 3, 14, 31), 15).length, 3);
    });

    test('fin avant le début, ou intervalle nul → aucune', () {
      expect(EventService.sessionStarts(start, DateTime(2026, 10, 3, 13), 15), isEmpty);
      expect(EventService.sessionStarts(start, DateTime(2026, 10, 3, 17), 0), isEmpty);
    });
  });

  group('migratePlayerNumbers', () {
    test('un joueur sans numéro le reçoit de son nom, sinon de son code', () async {
      final byName = Player()..name = '42'..qrcode = 'abcd-42'..event.value = event;
      final byCode = Player()..name = ''..qrcode = 'abcd-7'..event.value = event;
      await isar.writeTxn(() => isar.players.putAll([byName, byCode]));

      await IsarClient.migratePlayerNumbers(isar);

      expect((await isar.players.get(byName.id))!.number, 42);
      expect((await isar.players.get(byCode.id))!.number, 7);
      expect((await isar.players.get(p1.id))!.number, 1);
    });
  });

  group('setPlayerSessions', () {
    test('ajoute et retire en une fois, persisté', () async {
      await service().setPlayerSessions(p1, added: {s2.id}, removed: {s1.id});

      expect(await badgedSessions(), {s2.id});
    });

    test('sans changement, ne touche à rien', () async {
      await service().setPlayerSessions(p1, added: {}, removed: {});

      expect(await badgedSessions(), {s1.id});
    });

    test('retirer une session non badgée est sans effet', () async {
      await service().setPlayerSessions(p1, added: {}, removed: {s2.id});

      expect(await badgedSessions(), {s1.id});
    });
  });

  // s1 : 11 h à 11 h 15 ; s2 : 12 h à 12 h 15.
  final during1 = DateTime(2026, 10, 3, 11, 5);
  final during2 = DateTime(2026, 10, 3, 12, 5);
  final between = DateTime(2026, 10, 3, 11, 30);

  group('getPlayerByQrCode', () {
    test('carte inconnue ou code vide → null', () async {
      expect(await service().getPlayerByQrCode(event, 'x'), isNull);
      expect(await service().getPlayerByQrCode(event, ' '), isNull);
      expect((await service().getPlayerByQrCode(event, '1'))?.id, p1.id);
    });
  });

  group('badgeOpenSession', () {
    test('badge sur la session ouverte, persisté', () async {
      final result = await service().badgeOpenSession(event, p1, now: during2);

      expect(result, isA<ScanBadged>().having((r) => r.session.id, 'session', s2.id));
      expect(await badgedSessions(), {s1.id, s2.id});
    });

    test('aucune session ouverte → erreur, rien n\'est écrit', () async {
      final result = await service().badgeOpenSession(event, p1, now: between);

      expect(result, isA<ScanNoOpenSession>());
      expect(await badgedSessions(), {s1.id});
    });

    test('déjà présent → information, rien n\'est écrit', () async {
      final result = await service().badgeOpenSession(event, p1, now: during1);

      expect(result, isA<ScanAlreadyPresent>());
      expect(await badgedSessions(), {s1.id});
    });
  });

  group('badgeSession', () {
    test('session ouverte → badgé', () async {
      final result = await service().badgeSession(s2, p1, manual: false, now: during2);

      expect(result, isA<ScanBadged>());
      expect(await badgedSessions(), {s1.id, s2.id});
    });

    test('session non ouverte → erreur, rien n\'est écrit', () async {
      final result = await service().badgeSession(s2, p1, manual: false, now: during1);

      expect(result, isA<ScanSessionNotOpen>());
      expect(await badgedSessions(), {s1.id});
    });

    test('badgeage manuel → badgé quelle que soit l\'heure', () async {
      final result = await service().badgeSession(s2, p1, manual: true, now: between);

      expect(result, isA<ScanBadged>());
      expect(await badgedSessions(), {s1.id, s2.id});
    });

    test('déjà présent, même en manuel → information', () async {
      final result = await service().badgeSession(s1, p1, manual: true, now: between);

      expect(result, isA<ScanAlreadyPresent>());
      expect(await badgedSessions(), {s1.id});
    });
  });

  group('unbadgeSession', () {
    test('présent → retiré, persisté', () async {
      final result = await service().unbadgeSession(s1, p1);

      expect(result, isA<ScanRemovedFromSession>());
      expect(await badgedSessions(), <int>{});
    });

    test('absent → information, rien n\'est écrit', () async {
      final result = await service().unbadgeSession(s2, p1);

      expect(result, isA<ScanNotPresent>());
      expect(await badgedSessions(), {s1.id});
    });
  });

  /// L19 : les sessions suivent les paramètres de l'événement, sans coche.
  group('save', () {
    Future<List<Session>> sessionsOf(Event e) => isar.sessions.filter().event((q) => q.idEqualTo(e.id)).sortByNumber().findAll();

    test('un événement neuf reçoit ses sessions : une par intervalle, de début à fin', () async {
      final neuf = Event()
        ..name = 'Neuf'
        ..startDateTime = DateTime(2026, 10, 3, 10)
        ..endDateTime = DateTime(2026, 10, 3, 12)
        ..sessionTimeMinutes = 15
        ..sessionIntervalMinutes = 30;

      await service().save(neuf);

      final sessions = await sessionsOf(neuf);
      expect(sessions.map((s) => s.number), [1, 2, 3, 4]);
      expect(sessions.first.startTime, DateTime(2026, 10, 3, 10));
      expect(sessions.first.endTime, DateTime(2026, 10, 3, 10, 15));
      expect(sessions.last.startTime, DateTime(2026, 10, 3, 11, 30));
    });

    test('un existant enregistré sans regénération garde ses sessions et leurs badgeages', () async {
      event.name = 'Renommé';
      await service().save(event);

      expect((await sessionsOf(event)).map((s) => s.id), [s1.id, s2.id]);
      expect(await badgedSessions(), {s1.id});
    });

    test('regénérer recrée les sessions ; les badgeages sont perdus', () async {
      event
        ..startDateTime = DateTime(2026, 10, 3, 10)
        ..endDateTime = DateTime(2026, 10, 3, 11)
        ..sessionIntervalMinutes = 30;
      await service().save(event, regenerateSessions: true);

      final sessions = await sessionsOf(event);
      expect(sessions.map((s) => s.number), [1, 2]);
      expect(sessions.map((s) => s.id), isNot(contains(s1.id)));
      expect(await badgedSessions(), isEmpty);
      expect(await service().countBadges(event), 0);
    });
  });

  group('countBadges', () {
    test('compte les badgeages de toutes les sessions', () async {
      expect(await service().countBadges(event), 1);
      await service().badgeSession(s2, p1, manual: true);
      expect(await service().countBadges(event), 2);
    });

    test('un événement pas encore enregistré n\'en a aucun', () async {
      expect(await service().countBadges(Event()..name = 'Neuf'), 0);
    });
  });

  group('removePlayerFromSession', () {
    test('retire le joueur, persisté', () async {
      final session = (await isar.sessions.get(s1.id))!;
      await service().removePlayerFromSession(session, p1);

      expect(await badgedSessions(), <int>{});
    });

    test('sur une session non badgée, ne touche à rien', () async {
      final session = (await isar.sessions.get(s2.id))!;
      await service().removePlayerFromSession(session, p1);

      expect(await badgedSessions(), {s1.id});
    });
  });

  /// L18 : la logique des gestes JO-1 et EV-7, sans écran.
  group('generateMissingPlayers', () {
    Future<List<int>> numbers() async => (await isar.players.filter().event((q) => q.idEqualTo(event.id)).sortByNumber().numberProperty().findAll());

    test('complète de n+1 à N, avec le code de l\'événement', () async {
      p1.number = 1;
      await isar.writeTxn(() => isar.players.put(p1));
      event.qrSalt = 'abcd1234';

      await service().generateMissingPlayers(event, 3);

      expect(await numbers(), [1, 2, 3]);
      expect((await isar.players.filter().numberEqualTo(3).findFirst())!.qrcode, 'abcd1234-3');
    });

    test('un nombre inférieur ou égal aux existants ne crée rien', () async {
      await service().generateMissingPlayers(event, 1);
      await service().generateMissingPlayers(event, 0);

      expect(await isar.players.count(), 1);
    });
  });

  group('destroyPlayers', () {
    test('supprime les joueurs, leurs badgeages et leurs places de gagnants', () async {
      final draw = Draw.empty()..name = 'T'..event.value = event;
      final winner = DrawWinner.fromDraw(draw, p1, 1);
      await isar.writeTxn(() async {
        await isar.draws.put(draw);
        await draw.event.save();
        await isar.drawWinners.put(winner);
        await winner.draw.save();
        await winner.winner.save();
      });

      await service().destroyPlayers(event);

      expect(await isar.players.count(), 0);
      expect(await isar.drawWinners.count(), 0);
      final session = (await isar.sessions.get(s1.id))!;
      await session.players.load();
      expect(session.players, isEmpty);
    });
  });
}
