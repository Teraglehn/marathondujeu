import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/states/editor_state.dart';
import 'package:marathondujeu/src/ui/forms/draw_edit_form.dart';
import 'package:marathondujeu/src/ui/forms/event_edit_form.dart';
import 'package:marathondujeu/src/ui/forms/player_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/forms/player_group_edit_form.dart';

class EditDrawerWidget extends ConsumerWidget {

  final EditorState state;

  const EditDrawerWidget({
    super.key,
    required this.state,
  });
  
  Widget getEditForm(EditorState state, void Function() close){
    if(state.player != null){
      return PlayerEditForm(
        allowRemove: false,
        state.player!,
      );
    }
    if(state.event != null){
      return EventEditForm(
        allowRemove: false,
        state.event!,
      );
    }
    if(state.draw != null){
      // Clé : ouvrir un autre tirage (une copie, par exemple) recrée le formulaire.
      return DrawEditForm(
        key: ObjectKey(state.draw),
        allowRemove: false,
        state.draw!,
      );
    }
    if(state.playerGroup != null){
      return PlayerGroupEditForm(
        state.playerGroup!,
      );
    }
    return Container();
  }

  /// « Créer / Modifier un … » selon ce que le tiroir édite.
  String getTitle(BuildContext context, EditorState state) {
    final t = S.of(context);
    if (state.player != null) return t.editor_title_player;
    if (state.event != null) return state.event!.exist ? t.editor_title_event_edit : t.editor_title_event_create;
    if (state.draw != null) {
      if (state.draw!.isDrawn) return t.editor_title_draw_view;
      return state.draw!.exist ? t.editor_title_draw_edit : t.editor_title_draw_create;
    }
    if (state.playerGroup != null) return state.playerGroup!.exist ? t.editor_title_playerGroup_edit : t.editor_title_playerGroup_create;
    return '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cancel = ref.read(editorPodProvider.notifier).close;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(child: Text(getTitle(context, state), style: Theme.of(context).textTheme.titleLarge)),
                IconButton(onPressed: cancel, icon: const Icon(Icons.close), tooltip: S.of(context).utils_button_close),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: getEditForm(state, cancel),
          ),
        ],
      ),
    );
  }
}