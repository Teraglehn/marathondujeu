import 'package:flutter_test/flutter_test.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';

/// L17 : « modifié » compare des valeurs à l'objet ouvert — une valeur remise ne compte pas,
/// un champ numérique vidé compte, les choix en attente comptent.
void main() {
  group('eventFormIsDirty', () {
    final event = Event()
      ..name = 'Marathon'
      ..startDateTime = DateTime(2026, 9, 19, 10)
      ..endDateTime = DateTime(2026, 9, 20, 10)
      ..sessionTimeMinutes = 15
      ..sessionIntervalMinutes = 60
      ..qrSalt = '';

    bool dirty({String? name, DateTime? start, DateTime? end, int? sessionTime = 15, int? sessionInterval = 60, String? qrSalt}) =>
      eventFormIsDirty(event,
        name: name ?? event.name,
        start: start ?? event.startDateTime,
        end: end ?? event.endDateTime,
        sessionTime: sessionTime,
        sessionInterval: sessionInterval,
        qrSalt: qrSalt ?? event.qrSalt,
      );

    test('rien ne change → non modifié', () => expect(dirty(), isFalse));
    test('un nom, une date, une durée → modifié', () {
      expect(dirty(name: 'Autre'), isTrue);
      expect(dirty(start: DateTime(2026, 9, 19, 11)), isTrue);
      expect(dirty(end: DateTime(2026, 9, 21, 10)), isTrue);
      expect(dirty(sessionInterval: 30), isTrue);
    });
    test('un champ numérique vidé → modifié', () => expect(dirty(sessionTime: null), isTrue));
    test('protection allumée → modifié', () {
      expect(dirty(qrSalt: 'abcd1234'), isTrue);
    });
    test('une valeur remise à l\'identique → non modifié', () {
      expect(dirty(start: DateTime(2026, 9, 19, 10)), isFalse);
    });

    // L19 : seuls début, fin, durée et intervalle font recréer les sessions.
    group('eventSessionsChanged', () {
      bool changed({DateTime? start, DateTime? end, int? sessionTime = 15, int? sessionInterval = 60}) =>
        eventSessionsChanged(event,
          start: start ?? event.startDateTime,
          end: end ?? event.endDateTime,
          sessionTime: sessionTime,
          sessionInterval: sessionInterval,
        );

      test('rien ne change → non', () => expect(changed(), isFalse));
      test('une date, la durée, l\'intervalle → oui', () {
        expect(changed(start: DateTime(2026, 9, 19, 11)), isTrue);
        expect(changed(end: DateTime(2026, 9, 21, 10)), isTrue);
        expect(changed(sessionTime: 20), isTrue);
        expect(changed(sessionInterval: 30), isTrue);
      });
      test('le nom ou la protection ne comptent pas', () {
        expect(dirty(name: 'Autre'), isTrue);
        expect(changed(), isFalse);
      });
    });
  });

  group('playerFormIsDirty', () {
    final player = Player.empty()..name = '12'..bonusSession = 2;

    bool dirty({String? name, int? bonus = 2, Set<int> add = const {}, Set<int> remove = const {}}) =>
      playerFormIsDirty(player, name: name ?? player.name, bonus: bonus, sessionsToAdd: add, sessionsToRemove: remove);

    test('rien ne change → non modifié', () => expect(dirty(), isFalse));
    test('bonus changé puis remis → non modifié', () {
      expect(dirty(bonus: 3), isTrue);
      expect(dirty(bonus: 2), isFalse);
    });
    test('bonus vidé → modifié', () => expect(dirty(bonus: null), isTrue));
    test('un badgeage manuel en attente → modifié', () {
      expect(dirty(add: {4}), isTrue);
      expect(dirty(remove: {1}), isTrue);
    });
  });

  group('playerGroupFormIsDirty', () {
    final group = PlayerGroup.empty()..name = 'Bénévoles';
    test('nom identique → non, nom changé → oui', () {
      expect(playerGroupFormIsDirty(group, name: 'Bénévoles'), isFalse);
      expect(playerGroupFormIsDirty(group, name: 'Bénévole'), isTrue);
    });
  });

  group('drawFormIsDirty', () {
    final g1 = PlayerGroup.empty()..id = 1..name = 'g1';
    final g2 = PlayerGroup.empty()..id = 2..name = 'g2';
    final s1 = Session()..id = 1;
    final s2 = Session()..id = 2;
    // Un tirage neuf garde ses liens en mémoire — c'est le cas de « Créer un tirage ».
    final draw = Draw.empty()..name = 'Tirage N°1'..winnerCount = 1..minSessionNumber = 1..maxSessionNumber = 0;
    draw.excludedGroups.add(g1);
    draw.requiredSessions.add(s1);

    bool dirty({String? name, int? winnerCount = 1, int? min = 1, int? max = 0, Set<PlayerGroup>? excludedGroups, Set<PlayerGroup> requiredGroups = const {}, Set<Session> excludedSessions = const {}, Set<Session>? requiredSessions}) =>
      drawFormIsDirty(draw,
        name: name ?? draw.name,
        winnerCount: winnerCount,
        minSessionNumber: min,
        maxSessionNumber: max,
        excludedGroups: excludedGroups ?? {g1},
        requiredGroups: requiredGroups,
        excludedSessions: excludedSessions,
        requiredSessions: requiredSessions ?? {s1},
      );

    test('un tirage neuf avec ses défaut → non modifié (L17 Q1)', () => expect(dirty(), isFalse));
    test('nombre de gagnants changé puis remis', () {
      expect(dirty(winnerCount: 3), isTrue);
      expect(dirty(winnerCount: 1), isFalse);
    });
    test('un champ vidé → modifié', () => expect(dirty(max: null), isTrue));
    test('les groupes et sessions choisis comptent, par ensemble', () {
      expect(dirty(excludedGroups: {g1, g2}), isTrue);
      expect(dirty(excludedGroups: {}), isTrue);
      expect(dirty(requiredGroups: {g2}), isTrue);
      expect(dirty(excludedSessions: {s2}), isTrue);
      expect(dirty(requiredSessions: {s1, s2}), isTrue);
      // Le même objet relu de la base (même id) reste le même choix.
      expect(dirty(requiredSessions: {Session()..id = 1}), isFalse);
    });
  });
}
