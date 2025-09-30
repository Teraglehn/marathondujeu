import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/services_injector.dart';
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


  @override
  Widget build(BuildContext context) {

    final selectedEvent = ref.watch(selectedEventProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    final eventService = ref.watch(eventServiceProvider);
    final clock = ref.watch(clockPodProvider);

    final sessions = ref.watch(sessionsProvider(eventId: selectedEvent.value?.id));

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
        success: (player) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Joueur ${player.name} a été scanné"))),
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(children: [
                Text(DateFormat("Hms", S.of(context).localeName).format(clock.value ?? DateTime.now())),
                ElevatedButton(onPressed: () => eventService.generateSessions(selectedEvent), child: const Text("generate sessions")),
                ElevatedButton(onPressed: () => eventService.destroySession(selectedEvent), child: const Text("destroy sessions"))
              ])
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the number of columns based on screen width
                  int columns = (constraints.maxWidth / 150).floor();

                  return sessions.when(
                    data: (data) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Session session = data.elementAt(index);
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          color: session.isOpenAt(clock.value ?? DateTime.now()) ? Theme.of(context).colorScheme.primaryContainer : session.endTime.isBefore(clock.value ?? DateTime.now()) ? Colors.grey.shade400 : null,
                          elevation: 8,
                          child: InkWell(
                            onTap:() => goToSession(session),
                            child: Column(children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                                  child: Text(session.number.toString())
                                ),
                                title: Text("${DateFormat("Hm", S.of(context).localeName).format(session.startTime)} - ${DateFormat("Hm", S.of(context).localeName).format(session.endTime)}"),
                              ),
                            ])
                          )
                        );
                      },
                    ),
                    error: (_, e) => Center(child: Text(e.toString())),
                    loading: () => const SizedBox.shrink() 
                  );
                },
              ),
            ),
          ],
        )
      )),
    );
  }
}
