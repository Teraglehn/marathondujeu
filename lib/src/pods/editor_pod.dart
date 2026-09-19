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

  void editPlayerGroup(PlayerGroup playerGroup) {
    state = EditorState(playerGroup: playerGroup);
  }

  void newPlayerGroup(Event event) {
    final playerGroup = PlayerGroup.empty();
    playerGroup.event.value = event;

    state = EditorState(playerGroup: playerGroup);
  }

  void editDraw(Draw draw) {
    state = EditorState(draw: draw);
  }

  void close() {
    state = const EditorState();
  }
}