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
  
  // La clé vient du pod : neuve à chaque ouverture (une copie de tirage recrée le formulaire),
  // et c'est par elle que `requestClose` interroge le formulaire.
  Widget getEditForm(EditorState state){
    if(state.player != null){
      return PlayerEditForm(
        key: state.formKey,
        allowRemove: false,
        state.player!,
      );
    }
    if(state.event != null){
      return EventEditForm(
        key: state.formKey,
        allowRemove: false,
        state.event!,
      );
    }
    if(state.draw != null){
      return DrawEditForm(
        key: state.formKey,
        allowRemove: false,
        state.draw!,
      );
    }
    if(state.playerGroup != null){
      return PlayerGroupEditForm(
        key: state.formKey,
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
    void cancel() => ref.read(editorPodProvider.notifier).requestClose(context);
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
            child: getEditForm(state),
          ),
        ],
      ),
    );
  }
}