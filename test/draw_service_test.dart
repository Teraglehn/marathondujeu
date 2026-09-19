import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';

import 'isar_test_support.dart';

/// Générateur qui rend toujours la même valeur : rend le tirage prévisible.
class _FixedRandom implements Random {
  final int value;
  _FixedRandom(this.value);
  @override
  int nextInt(int max) => value < max ? value : max - 1;
  @override
  bool nextBool() => false;
  @override
  double nextDouble() => 0;
}

void main() {
  late Isar isar;
  late Event event;
  late Session s1, s2;
  late Player p1, p2, p3;

  DrawService service({Random? random}) {
    final client = TestIsarClient(isar);
    return DrawService(DrawRepository(client), DrawWinnerRepository(client), random: random);
  }

  Session session(int number) => Session()
    ..number = number
    ..startTime = DateTime(2026, 10, 3, 10 + number)
    ..endTime = DateTime(2026, 10, 3, 10 + number, 15)
    ..event.value = event;

  Player player(String name, {int bonus = 0}) => Player()
    ..name = name
    ..qrcode = name
    ..bonusSession = bonus
    ..event.value = event;

  setUpAll(() async {
    isar = await openTestIsar();
  });

  tearDownAll(() => isar.close(deleteFromDisk: true));

  /// Un événement, deux sessions ; p1 badge s1, p2 badge s1 et s2, p3 ne badge pas.
  setUp(() async {
    await isar.writeTxn(() => isar.clear());
    event = Event()..name = 'Test';
    s1 = session(1);
    s2 = session(2);
    p1 = player('p1');
    p2 = player('p2', bonus: 1);
    p3 = player('p3');
    await isar.writeTxn(() async {
      await isar.events.put(event);
      await isar.sessions.putAll([s1, s2]);
      await isar.players.putAll([p1, p2, p3]);
      for (final s in [s1, s2]) {
        await s.event.save();
      }
      for (final p in [p1, p2, p3]) {
        await p.event.save();
      }
      s1.players.addAll([p1, p2]);
      s2.players.add(p2);
      await s1.players.save();
      await s2.players.save();
    });
    await event.players.load();
    for (final p in [p1, p2, p3]) {
      await p.sessions.load();
    }
  });

  group('getWinner', () {
    test('un seul joueur : lui', () {
      expect(service().getWinner({p1}), same(p1));
    });

    test('aucun joueur : null', () {
      expect(service().getWinner({}), isNull);
    });

    test('le lot tiré désigne le joueur selon son poids', () {
      // p1 : 1 jeton (lot 0) ; p2 : 2 sessions + 1 bonus = 3 jetons (lots 1..3)
      final players = {p1, p2};
      expect(service(random: _FixedRandom(0)).getWinner(players), same(p1));
      expect(service(random: _FixedRandom(1)).getWinner(players), same(p2));
      expect(service(random: _FixedRandom(3)).getWinner(players), same(p2));
    });

    test('un joueur sans jeton n\'est jamais tiré', () {
      for (var v = 0; v < 4; v++) {
        expect(service(random: _FixedRandom(v)).getWinner({p3, p1}), same(p1));
      }
    });
  });

  group('getPlayerCount (filtres du tirage)', () {
    Future<int> count({
      int min = 0,
      int max = 0,
      Set<Player> excluded = const {},
      Set<Player> required = const {},
      Set<Session> excludedSessions = const {},
      Set<Session> requiredSessions = const {},
    }) =>
        service().getPlayerCount(event, min, max, excluded, required, excludedSessions, requiredSessions);

    test('sans filtre : tous les joueurs de l\'événement', () async {
      expect(await count(), 3);
    });

    test('minimum de sessions', () async {
      expect(await count(min: 1), 2);
      expect(await count(min: 2), 1);
    });

    test('maximum de sessions', () async {
      expect(await count(max: 1), 2);
    });

    test('joueurs exclus', () async {
      expect(await count(excluded: {p2}), 2);
    });

    test('joueurs requis : seuls eux, filtrés ensuite', () async {
      expect(await count(required: {p1, p3}), 2);
      expect(await count(required: {p1, p3}, min: 1), 1);
    });

    test('sessions exclues et requises', () async {
      expect(await count(excludedSessions: {s2}), 2);
      expect(await count(requiredSessions: {s1}), 2);
      expect(await count(requiredSessions: {s1, s2}), 1);
    });

    test('les joueurs requis du tirage ne sont pas mutés', () async {
      final draw = Draw.empty()
        ..minSessionNumber = 2
        ..event.value = event;
      draw.requiredPlayers.addAll([p1, p2, p3]);
      await isar.writeTxn(() async {
        await isar.draws.put(draw);
        await draw.event.save();
        await draw.requiredPlayers.save();
      });
      expect(await service().getPlayerList(draw), {p2});
      expect(draw.requiredPlayers.length, 3);
    });
  });

  test('les joueurs requis sont persistés avec le tirage', () async {
    final draw = Draw.empty()..event.value = event;
    draw.requiredPlayers.add(p1);
    await service().save(draw);

    final reloaded = await isar.draws.get(draw.id);
    await reloaded!.requiredPlayers.load();
    expect(reloaded.requiredPlayers, {p1});
  });
}
