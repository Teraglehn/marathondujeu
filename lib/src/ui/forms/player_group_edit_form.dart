import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/player_groups.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';

class PlayerGroupEditForm extends ConsumerStatefulWidget {

  final PlayerGroup group;

  final bool allowRemove;

  const PlayerGroupEditForm(
    this.group, 
    {
      this.allowRemove = true,
      super.key,
    });

  @override
  ConsumerState<PlayerGroupEditForm> createState() => _PlayerGroupEditFormState();
}

class _PlayerGroupEditFormState extends ConsumerState<PlayerGroupEditForm> implements DirtyAware {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState(){
    super.initState();
  }

  void save(){
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    
    ref.read(playerGroupsProvider().notifier)
      .save(widget.group)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void delete(){
    ref.read(playerGroupsProvider().notifier)
      .delete(widget.group)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).requestClose(context);
  }

  @override
  bool get isDirty => playerGroupFormIsDirty(widget.group, name: _nameKey.currentState?.value ?? widget.group.name);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              key: _nameKey,
              initialValue: widget.group.name,
              decoration: InputDecoration(
                labelText: S.of(context).data_playerGroup_name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_playerGroup_error_name_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.group.name = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.allowRemove) FilledButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: Text(S.of(context).utils_button_delete),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    minimumSize: const Size(0, 48),
                  ),
                ),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: cancel,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(S.of(context).utils_button_cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(S.of(context).utils_button_save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}