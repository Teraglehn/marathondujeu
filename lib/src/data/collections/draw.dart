import 'package:isar/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'draw.g.dart';

@collection
class Draw {
  Id id = Isar.autoIncrement;
  late String name;
  int minSessionNumber = 0;
  int maxSessionNumber = 0;
  int winnerCount = 1;
  
  final excludedSessions = IsarLinks<Session>();
  final requiredSessions = IsarLinks<Session>();

  final excludedPlayers = IsarLinks<Player>();

  @Backlink(to: "draw")
  final winners = IsarLinks<DrawWinner>();

  final event = IsarLink<Event>();

  Draw();

  factory Draw.empty() {
    return Draw()..name ="Tirage";
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
