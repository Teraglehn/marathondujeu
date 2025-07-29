import 'package:isar/isar.dart';

part 'player.g.dart';

@collection
class Player {
  Id id = Isar.autoIncrement;
  late String name;

  @Index(unique: true)
  late String qrcode;

  Player();

  factory Player.empty() {
    return Player()
      ..name = ''
      ..qrcode = '';
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
}
