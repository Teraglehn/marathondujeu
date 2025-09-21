import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/states/editor_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editor_pod.g.dart';

@riverpod
class EditorPod extends _$EditorPod {
  @override
  EditorState build() {
    return const EditorState();
  }

  void editPlayer(Player? player) {
    player ??= Player.empty();

    state = EditorState(player: player);
  }

  void editEvent(Event? event) {
    event ??= Event.empty();

    state = EditorState(event: event);
  }

  void close() {
    state = const EditorState();
  }
}