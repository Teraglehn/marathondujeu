import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/isar_client.dart';
import 'package:marathondujeu/src/services/services.dart';

import 'isar_test_support.dart';

void main() {
  late Isar isar;
  late Event event;
  late Player p1, p2;
  late PlayerGroup manual;

  PlayerGroupService groupService() => PlayerGroupService(PlayerGroupRepository(TestIsarClient(isar)));

  DrawService drawService() {
    final client = TestIsarClient(isar);
    return DrawService(DrawRepository(client), DrawWinnerRepository(client), PlayerGroupRepository(client));
  }

  setUpAll(() async {
    isar = await openTestIsar();
  });

  tearDownAll(() => isar.close(deleteFromDisk: true));

  /// Un événement, deux joueurs, un groupe manuel qui contient p1.
  setUp(() async {
    await isar.writeTxn(() => isar.clear());
    event = Event()..name = 'Test';
    p1 = Player()..name = '1'..qrcode = '1'..number = 1..event.value = event;
    p2 = Player()..name = '2'..qrcode = '2'..number = 2..event.value = event;
    manual = PlayerGroup()..name = 'Manuel'..event.value = event;
    manual.players.add(p1);
    await isar.writeTxn(() async {
      await isar.events.put(event);
      await isar.players.putAll([p1, p2]);
      await p1.event.save();
      await p2.event.save();
      await isar.playerGroups.put(manual);
      await manual.event.save();
      await manual.players.save();
    });
  });

  Future<Draw> drawWith({Set<PlayerGroup> excluded = const {}, Set<PlayerGroup> required = const {}, bool drawn = false}) async {
    final draw = Draw.empty()..event.value = event;
    draw.excludedGroups.addAll(excluded);
    draw.requiredGroups.addAll(required);
    if (drawn) draw.drawnAt = DateTime(2026, 10, 3);
    await drawService().save(draw);
    return draw;
  }

  group('catégorie', () {
    test('un groupe est manuel par défaut', () async {
      expect((await isar.playerGroups.get(manual.id))!.kind, PlayerGroupKind.manual);
    });

    test('migration : le groupe tenu par winnersGroup devient gagnants, les autres restent manuels', () async {
      final legacy = PlayerGroup()..name = 'Gagnants du tirage « A »'..event.value = event;
      await isar.writeTxn(() async {
        await isar.playerGroups.put(legacy);
        await legacy.event.save();
      });
      final draw = Draw.empty()..event.value = event..winnersGroup.value = legacy;
      await drawService().save(draw);

      await IsarClient.migratePlayerGroupKinds(isar);

      expect((await isar.playerGroups.get(legacy.id))!.kind, PlayerGroupKind.winners);
      expect((await isar.playerGroups.get(manual.id))!.kind, PlayerGroupKind.manual);
      // Une deuxième passe ne touche à rien.
      await IsarClient.migratePlayerGroupKinds(isar);
      expect((await isar.playerGroups.get(legacy.id))!.kind, PlayerGroupKind.winners);
    });
  });

  group('membres', () {
    test('ajouter un joueur l\'écrit ; déjà membre → false, rien n\'est écrit', () async {
      expect(await groupService().addPlayer(manual, p2), isTrue);
      var reloaded = (await isar.playerGroups.get(manual.id))!;
      await reloaded.players.load();
      expect(reloaded.players, {p1, p2});

      expect(await groupService().addPlayer(reloaded, p2), isFalse);
      reloaded = (await isar.playerGroups.get(manual.id))!;
      await reloaded.players.load();
      expect(reloaded.players, {p1, p2});
    });

    test('retirer un joueur', () async {
      final loaded = (await isar.playerGroups.get(manual.id))!;
      await loaded.players.load();
      await groupService().removePlayer(loaded, p1);

      final reloaded = (await isar.playerGroups.get(manual.id))!;
      await reloaded.players.load();
      expect(reloaded.players, isEmpty);
      expect(await isar.players.get(p1.id), isNotNull);
    });
  });

  group('tirages qui utilisent un groupe', () {
    test('aucun', () async {
      await drawWith();
      expect(await drawService().countUsingGroup(manual), 0);
    });

    test('exclu ou requis, préparé ou effectué : chacun compte une fois', () async {
      await drawWith(excluded: {manual});
      await drawWith(required: {manual}, drawn: true);
      await drawWith(excluded: {manual}, required: {manual});
      expect(await drawService().countUsingGroup(manual), 3);
    });
  });
}
