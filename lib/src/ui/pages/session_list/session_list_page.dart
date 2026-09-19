import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/clock_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionListPage extends ConsumerStatefulWidget       {
  const SessionListPage({super.key});

  @override
  ConsumerState<SessionListPage> createState() => _SessionListPageState();
}

class _SessionListPageState extends ConsumerState<SessionListPage> {

  @override
  void initState() {
    super.initState();
  }

  void goToSession(Session session){
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    mainNotifier.setSessionId(session.id);
    GoRouter.of(context).goNamed(Routes.session);
  }


  // Un élément de légende : un carré de la couleur des cartes et son explication.
  Widget legendItem(BuildContext context, Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey)),
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final selectedEvent = ref.watch(selectedEventProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    final clock = ref.watch(clockPodProvider);

    final sessions = ref.watch(sessionsProvider(eventId: selectedEvent.value?.id));
    final now = clock.value ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_sessionList_title),
        actions: [
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: selectedEvent.value,
              onChanged: (event) => mainNotifier.setEventId(event?.id),
            ),
          )
        ],
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        forceSelectedSession: false,
        success: (player) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).message_player_scanned(player.name)))),
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(DateFormat("Hms", S.of(context).localeName).format(now)),
              ])
            ),
            Expanded(
              child: sessions.when(
                data: (sessions) => GridView.extent(
                  maxCrossAxisExtent: 155.0,
                  childAspectRatio: 155 / 125,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: sessions.map((session) {
                    final open = session.isOpenAt(now);
                    return SizedBox(
                      width: 150,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        color: open ? Theme.of(context).colorScheme.primaryContainer : session.endTime.isBefore(now) ? Colors.grey.shade400 : null,
                        elevation: 8,
                        child: InkWell(
                          onTap:() => goToSession(session),
                          mouseCursor: SystemMouseCursors.click,
                          child: Column(children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                                child: Text(session.number.toString())
                              ),
                              title: Text(DateFormat("Hm", S.of(context).localeName).format(session.startTime)),
                              subtitle: Text(DateFormat("Hm", S.of(context).localeName).format(session.endTime)),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 12,
                                child: Text(session.players.length.toString(), style: Theme.of(context).textTheme.bodySmall)
                              ),
                              title: Text(S.of(context).page_sessionList_present(session.players.length), style: Theme.of(context).textTheme.bodySmall),
                              dense: true
                            ),
                          ])
                        )
                      )
                  );
                  }).toList(),
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              )
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))),
              child: Wrap(
                spacing: 24,
                runSpacing: 4,
                children: [
                  legendItem(context, Theme.of(context).colorScheme.primaryContainer, S.of(context).page_sessionList_legend_open),
                  legendItem(context, Colors.grey.shade400, S.of(context).page_sessionList_legend_past),
                  legendItem(context, Theme.of(context).cardColor, S.of(context).page_sessionList_legend_upcoming),
                ],
              ),
            ),
          ],
        )
      )),
    );
  }
}
