import 'package:isar/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement;
  late DateTime startTime;
  DateTime? endTime;

  final players = IsarLinks<Player>();

  final event = IsarLink<Event>();

  Session();

  factory Session.empty() {
    return Session()
      ..startTime = DateTime.now();
  }

  factory Session.fromEvent(DateTime startTime, int sessionTimeMinute) {
    return Session()
      ..startTime = startTime
      ..endTime = startTime.add(Duration(minutes: sessionTimeMinute));
  }

  endSession(){
    endTime = DateTime.now();
  }

  addPlayer(Player player){
    if(isOpen()) {
      players.add(player);
    }
  }

  bool isOpen(){
    var now = DateTime.now();
    return startTime.isBefore(now) && (endTime == null || endTime!.isAfter(now));
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
