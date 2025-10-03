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
        title: Text(S.of(context).page_session_title),
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        success: (player) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).message_player_scanned(player.name)))),
        useSelectedSession: !(selectedSession.value?.isOpen() ?? false),
        forceSelectedSession: manualMode,
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(children : [
                Text(DateFormat("Hms", S.of(context).localeName).format(clock.value ?? DateTime.now())),
                if(manualMode) ElevatedButton(onPressed: switchManualMode, child: Text(S.of(context).page_session_manualAddActive)),
                if(!manualMode) ElevatedButton(onPressed: switchManualMode, child: Text(S.of(context).page_session_manualAdd)),
              ])
            ),
            Expanded(
              child: players.when(
                data: (players) => GridView.extent(
                  maxCrossAxisExtent: 50.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: players.map((player) => CircleAvatar(
                        backgroundColor: selectedSession.value!.players.contains(player) ? Colors.green : Colors.grey,
                        child: Text(player.name)
                    )
                  ).toList()
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink() 
              )
            ),
          ],
        ))
      ),
    );
  }
}
