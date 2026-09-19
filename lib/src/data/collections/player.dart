import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'player.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;
  late String name;
  int bonusSession = 0;

  late String qrcode;

  final event = IsarLink<Event>();

  @Backlink(to: 'players')
  final sessions = IsarLinks<Session>();

  @Backlink(to: 'players')
  final groups = IsarLinks<PlayerGroup>();

  Player();

  factory Player.empty() {
    return Player()
      ..name = ''
      ..qrcode = '';
  }

  int getSessionNumber(){
    return sessions.toSet().length;
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Player) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;


  int getTokenCount(){
    return sessions.toSet().length + bonusSession;
  }
}
