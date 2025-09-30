import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/pods/clock_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_session.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';

class SessionPage extends ConsumerStatefulWidget {

  const SessionPage({super.key});

  @override
  ConsumerState<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<SessionPage> {

  bool manualMode = false;

  @override
  void initState() {
    super.initState();
  }

  void switchManualMode(){
    setState(() {
      manualMode = !manualMode;
    });
  }

  @override
  Widget build(BuildContext context) {

    final selectedEvent = ref.watch(selectedEventProvider);
    final selectedSession = ref.watch(selectedSessionProvider);
    final clock = ref.watch(clockPodProvider);
    final players = ref.watch(playersProvider(eventId: selectedEvent.value?.id));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).goNamed(Routes.sessionList), 
          icon: const Icon(Icons.arrow_back)
        ),
        title: Text(S.of(context).page_sessionList_title),
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        success: (player) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Joueur ${player.name} a été scanné"))),
        useSelectedSession: true,
        forceSelectedSession: manualMode,
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(children : [
                Text(DateFormat("Hms", S.of(context).localeName).format(clock.value ?? DateTime.now())),
                if(manualMode) ElevatedButton(onPressed: switchManualMode, child: const Text("Ajout Manuel ACTIF")),
                if(!manualMode) ElevatedButton(onPressed: switchManualMode, child: const Text("Ajout Manuel")),
              ])
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the number of columns based on screen width
                  int columns = (constraints.maxWidth / 50).floor();

                  return players.when(
                    data: (players) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns, // Number of columns
                        crossAxisSpacing: 10,   // Space between columns
                        mainAxisSpacing: 10,    // Space between rows
                      ),
                      itemCount: players.length, // Total number of items
                      itemBuilder: (context, index) {
                        return CircleAvatar(
                            backgroundColor: selectedSession.value!.players.contains(players[index]) ? Colors.green : Colors.grey,
                            child: Text(players[index].name)
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
        ))
      ),
    );
  }
}
