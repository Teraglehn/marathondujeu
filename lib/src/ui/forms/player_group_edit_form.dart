import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/player_groups.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';
import 'package:marathondujeu/src/ui/widgets/delete_player_group_dialog.dart';

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
  // Les tirages qui tiennent ce groupe : tant qu'il y en a, pas de suppression (L16 Q2).
  // Null tant que le compte n'est pas connu.
  int? _usedByDraws;

  @override
  void initState(){
    super.initState();
    if (widget.group.exist) {
      ref.read(drawServiceProvider).countUsingGroup(widget.group).then((count) {
        if (mounted) setState(() => _usedByDraws = count);
      });
    }
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

  Future<void> delete() async {
    if (await deletePlayerGroup(context, ref, widget.group)) {
      ref.read(editorPodProvider.notifier).close();
    }
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).requestClose(context);
  }

  @override
  bool get isDirty => playerGroupFormIsDirty(widget.group, name: _nameKey.currentState?.value ?? widget.group.name);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // Un groupe de gagnants ne se supprime pas (il appartient à son tirage) ; un groupe manuel
    // tenu par un tirage non plus, et le bouton grisé dit pourquoi.
    final canDelete = widget.allowRemove && widget.group.exist && !widget.group.isWinners;
    final usedBy = _usedByDraws ?? 0;
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
              readOnly: widget.group.isWinners,
              decoration: InputDecoration(
                labelText: s.data_playerGroup_name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return s.data_playerGroup_error_name_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.group.name = value!;
              },
            ),
          ),
          if (widget.group.isWinners) help(context, Icons.emoji_events, s.data_playerGroup_winners_help),
          if (canDelete && usedBy > 0) help(context, Icons.lock_outline, s.data_playerGroup_usedByDraws(usedBy)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (canDelete) FilledButton.icon(
                  onPressed: _usedByDraws == 0 ? delete : null,
                  icon: const Icon(Icons.delete),
                  label: Text(s.utils_button_delete),
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
                  child: Text(s.utils_button_cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(s.utils_button_save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget help(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
