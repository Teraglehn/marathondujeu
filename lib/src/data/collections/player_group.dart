import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'player_group.g.dart';

@collection
class PlayerGroup {
  Id id = Isar.autoIncrement;
  String name = "";

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
}
