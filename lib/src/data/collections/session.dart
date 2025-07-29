import 'package:isar/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement;
  late DateTime startTime;
  DateTime? endTime;
  
  final players = IsarLinks<Player>();

  Session();

  factory Session.empty() {
    return Session()
      ..startTime = DateTime.now();
  }

  endSession(){
    endTime = DateTime.now();
  }

  addPlayer(Player player){
    if(endTime == null || DateTime.now().isBefore(endTime!)) {
      players.add(player);
    }
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
