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
    return DrawService(DrawRepository(client), DrawWinnerRepository(client), PlayerGroupRepository(client), random: random);
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

  group('getEligibilityFor (filtres du tirage)', () {
    Future<({int players, int tokens})> eligibility({
      int min = 0,
      int max = 0,
      Set<Player> excluded = const {},
      Set<Player> required = const {},
      Set<PlayerGroup> excludedGroups = const {},
      Set<PlayerGroup> requiredGroups = const {},
      Set<Session> excludedSessions = const {},
      Set<Session> requiredSessions = const {},
    }) =>
        service().getEligibilityFor(event, minSessionNumber: min, maxSessionNumber: max, excludedPlayers: excluded, requiredPlayers: required,
          excludedGroups: excludedGroups, requiredGroups: requiredGroups, excludedSessions: excludedSessions, requiredSessions: requiredSessions);

    Future<int> count({
      int min = 0,
      int max = 0,
      Set<Player> excluded = const {},
      Set<Player> required = const {},
      Set<PlayerGroup> excludedGroups = const {},
      Set<PlayerGroup> requiredGroups = const {},
      Set<Session> excludedSessions = const {},
      Set<Session> requiredSessions = const {},
    }) async => (await eligibility(min: min, max: max, excluded: excluded, required: required, excludedGroups: excludedGroups,
        requiredGroups: requiredGroups, excludedSessions: excludedSessions, requiredSessions: requiredSessions)).players;

    Future<PlayerGroup> group(String name, List<Player> players) async {
      final g = PlayerGroup.empty()..name = name..event.value = event;
      g.players.addAll(players);
      await isar.writeTxn(() async {
        await isar.playerGroups.put(g);
        await g.event.save();
        await g.players.save();
      });
      return g;
    }

    test('groupes exclus et requis, résolus en joueurs', () async {
      final g12 = await group('g12', [p1, p2]);
      final g3 = await group('g3', [p3]);
      expect(await count(excludedGroups: {g12}), 0);
      expect(await count(requiredGroups: {g12}), 2);
      expect(await count(requiredGroups: {g12}, excluded: {p1}), 1);
      expect(await count(requiredGroups: {g3}, required: {p1}), 1);
    });

    test('sans filtre : tous les joueurs qui ont un jeton, et leurs jetons', () async {
      // p3 n'a ni session ni bonus : hors de l'urne.
      final e = await eligibility();
      expect(e.players, 2);
      expect(e.tokens, 4);
    });

    test('minimum de sessions', () async {
      expect(await count(min: 1), 2);
      expect(await count(min: 2), 1);
    });

    test('maximum de sessions', () async {
      expect(await count(max: 1), 1);
    });

    test('joueurs exclus', () async {
      expect(await count(excluded: {p2}), 1);
    });

    test('joueurs requis : seuls eux, filtrés ensuite', () async {
      expect(await count(required: {p1, p3}), 1);
      expect(await count(required: {p1, p3}, min: 1), 1);
    });

    test('sessions exclues et requises', () async {
      expect(await count(excludedSessions: {s2}), 1);
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

  group('lancement et copie', () {
    Future<Draw> drawWith({int winnerCount = 2}) async {
      final draw = Draw.empty()..name = 'A'..minSessionNumber = 1..winnerCount = winnerCount..event.value = event;
      await service().save(draw);
      return draw;
    }

    test('lancer date le tirage et désigne les gagnants ; relancer est refusé', () async {
      final draw = await drawWith();
      expect(draw.isDrawn, isFalse);

      await service().calculateDraw(draw);

      final reloaded = await isar.draws.get(draw.id);
      expect(reloaded!.isDrawn, isTrue);
      await reloaded.winners.load();
      expect(reloaded.winners.length, 2);
      // Les gagnants forment un groupe de l'événement.
      await reloaded.winnersGroup.load();
      final group = reloaded.winnersGroup.value!;
      expect(group.name, 'Gagnants du tirage « A »');
      expect(group.kind, PlayerGroupKind.winners);
      await group.players.load();
      expect(group.players, reloaded.winners.map((w) => w.winner.value!).toSet());
      expect((await isar.playerGroups.get(group.id))!.event.value, event);
      expect(() => service().calculateDraw(reloaded), throwsStateError);
    });

    test('sans joueur éligible, le tirage est effectué quand même, sans gagnant', () async {
      final draw = Draw.empty()..name = 'vide'..minSessionNumber = 9..event.value = event;
      await service().save(draw);
      await service().calculateDraw(draw);
      final reloaded = await isar.draws.get(draw.id);
      expect(reloaded!.isDrawn, isTrue);
      await reloaded.winners.load();
      expect(reloaded.winners, isEmpty);
    });

    test('la copie reprend tout, exclut le groupe des gagnants, et reste en mémoire', () async {
      final draw = await drawWith();
      draw.excludedSessions.add(s2);
      draw.requiredPlayers.addAll([p1, p2]);
      await service().save(draw);
      await service().calculateDraw(draw);
      final source = await isar.draws.get(draw.id);
      await source!.winners.load();
      final winners = source.winners.map((w) => w.winner.value!).toSet();
      expect(winners, isNotEmpty);

      final copy = await service().createDrawFromDraw(source);
      expect(copy.exist, isFalse);
      expect(copy.isDrawn, isFalse);
      await service().save(copy);

      final reloaded = await isar.draws.get(copy.id);
      expect(reloaded!.name, 'Tirage N°${draw.id + 1}');
      expect(reloaded.isDrawn, isFalse);
      expect(reloaded.minSessionNumber, 1);
      expect(reloaded.winnerCount, 2);
      await Future.wait([reloaded.excludedGroups.load(), reloaded.requiredPlayers.load(), reloaded.excludedSessions.load(), reloaded.event.load()]);
      expect(reloaded.excludedGroups, {source.winnersGroup.value});
      expect(reloaded.requiredPlayers, {p1, p2});
      expect(reloaded.excludedSessions, {s2});
      expect(reloaded.event.value, event);
      expect(await service().getPlayerList(reloaded), isNot(contains(winners.first)));
    });
  });
}
