import 'package:flutter/material.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';

/// « Modification en cours, voulez-vous quitter ? » — vrai pour *Quitter*. Échap vaut *Revenir*.
Future<bool> confirmLeaveEditor(BuildContext context) async {
  final leave = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(S.of(context).editor_dirty_title),
      content: Text(S.of(context).editor_dirty_text),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(S.of(context).editor_dirty_stay),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          child: Text(S.of(context).editor_dirty_leave),
        ),
      ],
    ),
  );
  return leave == true;
}
