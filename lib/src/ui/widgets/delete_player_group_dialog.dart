import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';

/// Supprime un groupe après confirmation, depuis la liste ou depuis son éditeur. Un groupe tenu
/// par un tirage n'est pas supprimé : la modale dit pourquoi (L16 Q2). Rend `true` si supprimé.
Future<bool> deletePlayerGroup(BuildContext context, WidgetRef ref, PlayerGroup group) async {
  final usedBy = await ref.read(drawServiceProvider).countUsingGroup(group);
  if (!context.mounted) return false;
  final s = S.of(context);
  if (usedBy > 0) {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(group.name),
        content: Text(s.data_playerGroup_usedByDraws(usedBy)),
        actions: [
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text(s.utils_button_close)),
        ],
      ),
    );
    return false;
  }
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(s.utils_button_delete),
      content: Text(s.data_playerGroup_delete_confirm(group.name)),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(s.utils_button_cancel)),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error, foregroundColor: Theme.of(context).colorScheme.onError),
          child: Text(s.utils_button_delete),
        ),
      ],
    ),
  );
  if (confirmed != true) return false;
  await ref.read(playerGroupServiceProvider).delete(group);
  return true;
}
