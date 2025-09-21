import 'package:isar/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'draw.g.dart';

@collection
class Draw {
  Id id = Isar.autoIncrement;
  int minSessionNumber = 0;
  int maxSessionNumber = 0;
  
  final excludedSessions = IsarLinks<Session>();
  final requiredSessions = IsarLinks<Session>();

  final excludedPlayers = IsarLinks<Player>();

  final List<String> results = [];

  final event = IsarLink<Event>();

  Draw();

  factory Draw.empty() {
    return Draw();
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Session) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;
}
