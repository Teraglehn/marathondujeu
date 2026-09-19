import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';

/// Un formulaire qui sait dire s'il a été modifié depuis son ouverture.
abstract interface class DirtyAware {
  bool get isDirty;
}

// Le calcul « modifié » de chaque formulaire : les valeurs à l'écran contre l'objet tel
// qu'ouvert. Des valeurs, pas des frappes : une valeur remise ne compte pas ; un champ
// numérique vidé (`null`) compte.

bool eventFormIsDirty(Event event, {
  required String name,
  required DateTime? start,
  required DateTime? end,
  required int? sessionTime,
  required int? sessionInterval,
  required String qrSalt,
  required bool generateSessions,
}) =>
  name != event.name
  || start != event.startDateTime
  || end != event.endDateTime
  || sessionTime != event.sessionTimeMinutes
  || sessionInterval != event.sessionIntervalMinutes
  || qrSalt != event.qrSalt
  || generateSessions;

/// Les badgeages manuels en attente comptent comme une modification.
bool playerFormIsDirty(Player player, {
  required String name,
  required int? bonus,
  required Set<int> sessionsToAdd,
  required Set<int> sessionsToRemove,
}) =>
  name != player.name
  || bonus != player.bonusSession
  || sessionsToAdd.isNotEmpty
  || sessionsToRemove.isNotEmpty;

bool playerGroupFormIsDirty(PlayerGroup group, {required String name}) => name != group.name;

/// Les groupes et sessions choisis sont comparés aux liens du tirage tel qu'ouvert.
bool drawFormIsDirty(Draw draw, {
  required String name,
  required int? winnerCount,
  required int? minSessionNumber,
  required int? maxSessionNumber,
  required Set<PlayerGroup> excludedGroups,
  required Set<PlayerGroup> requiredGroups,
  required Set<Session> excludedSessions,
  required Set<Session> requiredSessions,
}) =>
  name != draw.name
  || winnerCount != draw.winnerCount
  || minSessionNumber != draw.minSessionNumber
  || maxSessionNumber != draw.maxSessionNumber
  || !_sameAs(excludedGroups, draw.excludedGroups)
  || !_sameAs(requiredGroups, draw.requiredGroups)
  || !_sameAs(excludedSessions, draw.excludedSessions)
  || !_sameAs(requiredSessions, draw.requiredSessions);

// Les liens d'un tirage neuf sont un ensemble par identité : on les relit par égalité (l'id).
bool _sameAs<T>(Set<T> chosen, IsarLinks<T> links) => setEquals(chosen, {...Draw.linked(links)});
