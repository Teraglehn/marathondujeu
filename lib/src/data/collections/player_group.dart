import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'player_group.g.dart';

/// La catégorie d'un groupe : fait main par l'organisateur, ou créé par un tirage pour ses
/// gagnants. L'ordre est celui du stockage (ordinal) : `manual` en premier, valeur des groupes
/// d'avant le champ.
enum PlayerGroupKind { manual, winners }

@collection
class PlayerGroup {
  Id id = Isar.autoIncrement;
  String name = "";

  @enumerated
  PlayerGroupKind kind = PlayerGroupKind.manual;

  final players = IsarLinks<Player>();

  final event = IsarLink<Event>();

  PlayerGroup();

  factory PlayerGroup.empty() {
    return PlayerGroup();
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is PlayerGroup) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;

  @ignore
  bool get isWinners => kind == PlayerGroupKind.winners;
}
