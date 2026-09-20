import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';

/// La carte d'une session dans la liste : numéro, début, fin, « n présents ». Colorée quand la
/// session est ouverte à [now], grise quand elle est passée. Widget pur — le guide (L12b)
/// l'affiche avec une session d'exemple.
class SessionCard extends StatelessWidget {
  static const double width = 150;

  final Session session;
  /// À part : `session.players` est un lien Isar, qui refuse un objet non enregistré (le guide).
  final int presentCount;
  final DateTime now;
  final VoidCallback? onTap;

  const SessionCard({super.key, required this.session, required this.presentCount, required this.now, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final timeFormat = DateFormat("Hm", S.of(context).localeName);
    final open = session.isOpenAt(now);
    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: open ? scheme.primaryContainer : session.endTime.isBefore(now) ? Colors.grey.shade400 : null,
        elevation: 8,
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          child: Column(children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.secondary,
                foregroundColor: scheme.onSecondary,
                child: Text(session.number.toString())
              ),
              title: Text(timeFormat.format(session.startTime)),
              subtitle: Text(timeFormat.format(session.endTime)),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 12,
                child: Text(presentCount.toString(), style: Theme.of(context).textTheme.bodySmall)
              ),
              title: Text(S.of(context).page_sessionList_present(presentCount), style: Theme.of(context).textTheme.bodySmall),
              dense: true
            ),
          ])
        )
      )
    );
  }
}
