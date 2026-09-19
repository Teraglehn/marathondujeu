import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement;
  late DateTime startTime;
  late DateTime endTime;
  late int number;

  final players = IsarLinks<Player>();

  final event = IsarLink<Event>();

  Session();

  factory Session.empty() {
    return Session()
      ..startTime = DateTime.now(); 
  }

  factory Session.fromEvent(DateTime startTime, int number, Event event) {
    return Session()
      ..number = number
      ..startTime = startTime
      ..endTime = startTime.add(Duration(minutes: event.sessionTimeMinutes))
      ..event.value = event;
  }

  void addPlayer(Player player){
    if(isOpen()) {
      players.add(player);
    }
  }

  void forceAddPlayer(Player player){
    players.add(player);
  }

  bool isOpen(){
    return isOpenAt(DateTime.now());
  }

  bool isOpenAt(DateTime time){
    return startTime.isBefore(time) && endTime.isAfter(time);
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
