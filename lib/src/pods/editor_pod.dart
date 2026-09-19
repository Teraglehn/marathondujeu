import 'package:flutter/widgets.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/states/editor_state.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';
import 'package:marathondujeu/src/ui/widgets/leave_editor_dialog.dart';
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

    state = EditorState(player: player, formKey: GlobalKey());
  }

  void editEvent(Event? event) {
    event ??= Event.empty();

    state = EditorState(event: event, formKey: GlobalKey());
  }

  void editPlayerGroup(PlayerGroup playerGroup) {
    state = EditorState(playerGroup: playerGroup, formKey: GlobalKey());
  }

  void newPlayerGroup(Event event) {
    final playerGroup = PlayerGroup.empty();
    playerGroup.event.value = event;

    state = EditorState(playerGroup: playerGroup, formKey: GlobalKey());
  }

  void editDraw(Draw draw) {
    state = EditorState(draw: draw, formKey: GlobalKey());
  }

  /// La seule voie de fermeture sans enregistrer : *Annuler*, la croix, Échap, le clic à côté.
  /// Un formulaire modifié demande d'abord « Quitter / Revenir ».
  Future<void> requestClose(BuildContext context) async {
    final form = state.formKey?.currentState;
    if (form is DirtyAware && (form as DirtyAware).isDirty) {
      if (!await confirmLeaveEditor(context)) return;
    }
    close();
  }

  void close() {
    state = const EditorState();
  }
}
