import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/ui/widgets/toast.dart';

/// Ferme un événement (L21), depuis la liste ou depuis son éditeur : le fichier de sauvegarde
/// est réécrit d'abord s'il y en a un — une écriture en échec vaut « pas sauvegardé ». Toujours
/// une modale (Q1), plus explicite quand rien ne garde l'événement. Confirmé → la cascade, plus
/// d'événement sélectionné, un toast qui nomme le fichier. Rend `true` si fermé.
Future<bool> closeEvent(BuildContext context, WidgetRef ref, Event event) async {
  final s = S.of(context);
  final path = event.backupPath;
  final saved = path != null && await ref.read(backupServiceProvider).writeNow(event);
  if (!context.mounted) return false;
  final scheme = Theme.of(context).colorScheme;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(saved ? s.event_close_title(event.name) : s.event_close_unsaved_title),
      content: Text(saved ? s.event_close_saved_text(path) : s.event_close_unsaved_text(event.name)),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(s.utils_button_cancel)),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: saved ? null : FilledButton.styleFrom(backgroundColor: scheme.error, foregroundColor: scheme.onError),
          child: Text(saved ? s.event_close_confirm : s.event_close_anyway),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return false;
  await ref.read(eventsProvider().notifier).destroy(event);
  if (!context.mounted) return true;
  ref.read(mainPodProvider.notifier).setEventId(null);
  Toast.show(context, saved ? s.event_closed_saved(event.name, path) : s.event_closed(event.name));
  return true;
}
