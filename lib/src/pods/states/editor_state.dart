import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marathondujeu/src/data/data.dart';

part 'editor_state.freezed.dart';

@freezed
class EditorState with _$EditorState{
  const EditorState._();

  const factory EditorState({
    Player? player,
    Event? event,
    Draw? draw,
    PlayerGroup? playerGroup,
}) = _EditorState;

  bool get isEditing => player != null || event != null || draw != null || playerGroup != null;
}