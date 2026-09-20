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
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:marathondujeu/src/ui/widgets/session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionListPage extends ConsumerStatefulWidget       {
  const SessionListPage({super.key});

  @override
  ConsumerState<SessionListPage> createState() => _SessionListPageState();
}

class _SessionListPageState extends ConsumerState<SessionListPage> {

  // Les cibles de l'aide de la page (L12) : la carte visée est la session ouverte s'il y en a
  // une, la première sinon.
  final _clockKey = GlobalKey();
  final _cardKey = GlobalKey();
  final _legendKey = GlobalKey();
  final _scanKey = GlobalKey();
  bool _openShown = false;

  List<HelpStep> helpSteps() {
    final s = S.of(context);
    final noSession = _cardKey.currentContext == null;
    return [
      HelpStep(s.help_sessionList_1),
      HelpStep(s.help_sessionList_2, target: _clockKey),
      if (noSession) HelpStep(s.help_sessionList_3_empty),
      if (!noSession) HelpStep(_openShown ? s.help_sessionList_3_open : s.help_sessionList_3_closed, target: _cardKey),
      HelpStep(s.help_sessionList_4, target: _scanKey),
      HelpStep(s.help_sessionList_5, target: _legendKey),
    ];
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
          ScanStatus(key: _scanKey, mode: ScanMode.badgeOpenSession),
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: selectedEvent.value,
              onChanged: (event) => mainNotifier.setEventId(event?.id),
            ),
          ),
          HelpButton(steps: helpSteps),
        ],
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        mode: ScanMode.badgeOpenSession,
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(DateFormat("Hms", S.of(context).localeName).format(now), key: _clockKey),
              ])
            ),
            Expanded(
              child: sessions.when(
                data: (sessions) {
                  final helpSession = sessions.where((x) => x.isOpenAt(now)).firstOrNull ?? sessions.firstOrNull;
                  _openShown = helpSession?.isOpenAt(now) ?? false;
                  return GridView.extent(
                  maxCrossAxisExtent: 155.0,
                  childAspectRatio: 155 / 125,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: sessions.map((session) => SessionCard(
                    key: session == helpSession ? _cardKey : null,
                    session: session,
                    presentCount: session.players.length,
                    now: now,
                    onTap: () => goToSession(session),
                  )).toList(),
                  );
                },
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              )
            ),
            Container(
              key: _legendKey,
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
