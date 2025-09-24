import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/states/editor_state.dart';
import 'package:marathondujeu/src/ui/forms/event_edit_form.dart';
import 'package:marathondujeu/src/ui/forms/player_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditDrawerWidget extends ConsumerWidget {

  final EditorState state;

  const EditDrawerWidget({
    super.key,
    required this.state,
  });
  
  Widget getEditForm(EditorState state, void Function() close){
    if(state.player != null){
      return PlayerEditForm(
        state.player!,
      );
    }
    if(state.event != null){
      return EventEditForm(
        state.event!,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cancel = ref.read(editorPodProvider.notifier).close;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.5,
      child: Column(
        children: [
          Expanded(
            child: getEditForm(state, cancel),
          ),
        ],
      ),
    );
  }
}