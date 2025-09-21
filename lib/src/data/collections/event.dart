import 'package:isar/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'event.g.dart';

@collection
class Event {
  Id id = Isar.autoIncrement;
  late String name;
  late String qrSalt;
  int sessionTimeMinutes = 15;
  int sessionIntervalMinutes = 60;

  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now().add(const Duration(days: 1));

  int playerCardHeight = 0;
  int playerCardWidth = 0;

  int qrCodePosX = 0;
  int qrCodePosY = 0;

  int idPosX = 0;
  int idPosY = 0;
  
  @Backlink(to: 'event')
  final players = IsarLinks<Player>();

  @Backlink(to: 'event')
  final sessions = IsarLinks<Session>();

  Event();

  factory Event.empty() {
    return Event();
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
