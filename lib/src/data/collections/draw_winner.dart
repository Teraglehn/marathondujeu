import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'draw_winner.g.dart';

@collection
class DrawWinner {
  Id id = Isar.autoIncrement;
  late int position;
  final draw = IsarLink<Draw>();
  final winner = IsarLink<Player>();

  DrawWinner();

  factory DrawWinner.fromDraw(Draw draw, Player winner, int position) {
    return DrawWinner()
      ..draw.value = draw
      ..winner.value = winner
      ..position = position;
  }

  @ignore
  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is DrawWinner) {
      return id == other.id && exist;
    }
    return false;
  }

  @ignore
  bool get exist => id != Isar.autoIncrement;
}
