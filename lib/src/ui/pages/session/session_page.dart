import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/clock_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_session.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/player_bubble.dart';

class SessionPage extends ConsumerStatefulWidget {

  const SessionPage({super.key});

  @override
  ConsumerState<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<SessionPage> {
  static const _popOut = Duration(milliseconds: 300);
  static const _popIn = Duration(milliseconds: 600);
  static const _numberIdle = Duration(seconds: 2);

  bool manualMode = false;
  bool removeMode = false;
  final _numberController = TextEditingController();
  // Le numéro validé qui ne correspond à aucun joueur, pour le dire.
  int? _unknownNumber;
  // Deux secondes sans saisie : le champ Numéro rend le focus à la douchette.
  Timer? _numberIdleTimer;

  // Animation locale à la page : les billes qui quittent Absents (pop out), celles qui arrivent
  // dans Présents (pop in), et les zones telles qu'affichées au dernier rendu (voir detectArrivals).
  final Set<int> _leaving = {};
  final Set<int> _arriving = {};
  int? _shownSessionId;
  Set<int> _shownPresent = {};
  Set<int> _shownAbsent = {};

  @override
  void dispose() {
    _numberIdleTimer?.cancel();
    _numberController.dispose();
    super.dispose();
  }

  void switchManualMode(){
    setState(() {
      manualMode = !manualMode;
    });
  }

  // Au rendu, les joueurs qui viennent d'arriver par rapport au rendu précédent : ceux qui
  // étaient dans Absents y font leur pop out, puis leur pop in dans Présents ; les autres font
  // le pop in directement. Détecté au rendu, et non à l'arrivée d'une nouvelle session : le
  // service ajoute le joueur dans l'objet déjà affiché avant d'écrire, et n'importe quel rendu
  // (horloge, « numéro inconnu ») peut tomber entre les deux.
  void detectArrivals(Session session, Set<int> presentIds) {
    if (_shownSessionId != session.id) {
      _shownSessionId = session.id;
      return;
    }
    final added = presentIds.difference(_shownPresent).difference(_leaving).difference(_arriving);
    if (added.isEmpty) return;
    final fromAbsent = added.intersection(_shownAbsent);
    _leaving.addAll(fromAbsent);
    _arriving.addAll(added.difference(fromAbsent));
    if (fromAbsent.isEmpty) return;
    Future.delayed(_popOut, () {
      if (!mounted) return;
      setState(() {
        _leaving.removeAll(fromAbsent);
        _arriving.addAll(fromAbsent);
      });
    });
  }

  void arrived(int playerId) {
    if (mounted) setState(() => _arriving.remove(playerId));
  }

  void remove(Player player) {
    final session = ref.read(selectedSessionProvider).value;
    if (session == null) return;
    ref.read(eventServiceProvider).removePlayerFromSession(session, player);
  }

  // Le champ Numéro rend le focus : la douchette reprend la main.
  void releaseNumberField({bool clear = false}) {
    _numberIdleTimer?.cancel();
    if (clear) _numberController.clear();
    FocusScope.of(context).unfocus();
  }

  // Une saisie qui n'est pas que des chiffres vient de la douchette (le code porte le sel) :
  // le champ se vide et rend la main, l'écouteur de la douchette fait le badgeage. Sinon,
  // deux secondes sans saisie rendent la main.
  void onNumberChanged(String text) {
    if (int.tryParse(text) == null && text.isNotEmpty) {
      releaseNumberField(clear: true);
      return;
    }
    _numberIdleTimer?.cancel();
    _numberIdleTimer = Timer(_numberIdle, () {
      if (mounted) releaseNumberField();
    });
  }

  // Entrée ou le bouton du champ Numéro : badge le joueur de ce numéro, ou le retire en mode
  // suppression. Entrée rend toujours la main ; le champ se vide si le joueur est trouvé.
  void submitNumber(Session session, List<Player> players, {required bool canSubmit}) {
    releaseNumberField();
    final event = ref.read(selectedEventProvider).value;
    final number = int.tryParse(_numberController.text);
    if (!canSubmit || event == null || number == null) return;

    final player = players.where((p) => p.number == number).firstOrNull;
    setState(() => _unknownNumber = player == null ? number : null);
    if (player == null) return;

    final service = ref.read(eventServiceProvider);
    if (removeMode) {
      service.removePlayerFromSession(session, player);
    } else {
      service.forceAddPlayerToSession(event, session, player);
    }
    _numberController.clear();
  }

  Widget bubble(BuildContext context, Player player, {required bool present}) {
    final bubble = PlayerBubble(
      number: player.number,
      color: present ? Colors.green : Colors.grey,
      foregroundColor: Colors.white,
    );
    Widget child = bubble;
    if (present && removeMode) {
      child = RemovableBubble(bubble: bubble, label: S.of(context).page_session_remove, onRemove: () => remove(player));
    }
    if (present && _arriving.contains(player.id)) {
      return _Pop(key: ValueKey('in-${player.id}'), duration: _popIn, onDone: () => arrived(player.id), child: child);
    }
    if (!present && _leaving.contains(player.id)) {
      return _Pop(key: ValueKey('out-${player.id}'), duration: _popOut, out: true, child: child);
    }
    return child;
  }

  Widget zone(BuildContext context, String title, List<Player> players, {required bool present}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: players.map((player) => bubble(context, player, present: present)).toList(),
          ),
        ),
      ],
    );
  }

  // Une ligne d'aide : une bille de la couleur donnée (ou une icône) et son explication.
  Widget helpLine(BuildContext context, Color? color, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: color != null ? CircleAvatar(backgroundColor: color) : const Icon(Icons.touch_app, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final selectedEvent = ref.watch(selectedEventProvider);
    final session = ref.watch(selectedSessionProvider).value;
    final now = ref.watch(clockPodProvider).value ?? DateTime.now();
    final players = ref.watch(playersProvider(eventId: selectedEvent.value?.id)).value ?? [];
    final sessions = ref.watch(sessionsProvider(eventId: selectedEvent.value?.id)).value ?? [];

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
        useSelectedSession: !(session?.isOpen() ?? false),
        forceSelectedSession: manualMode,
        child : session == null ? const SizedBox.shrink() : body(context, session, now, players, sessions),
      )),
    );
  }

  Widget body(BuildContext context, Session session, DateTime now, List<Player> players, List<Session> sessions) {
    final s = S.of(context);
    final error = Theme.of(context).colorScheme.error;
    final timeFormat = DateFormat("Hm", s.localeName);

    // Présents : les joueurs de la session. Absents : ceux qui ont badgé une autre session.
    // Les billes en pop out restent dans Absents le temps de l'animation.
    final presentIds = session.players.map((p) => p.id).toSet();
    detectArrivals(session, presentIds);
    final badgedAnywhere = {for (final other in sessions) ...other.players.map((p) => p.id)};
    final presentShown = presentIds.difference(_leaving);
    final absentShown = badgedAnywhere.difference(presentIds).union(_leaving);
    _shownPresent = presentShown;
    _shownAbsent = absentShown;

    final sorted = players.toList()..sort((a, b) => a.number.compareTo(b.number));
    final present = sorted.where((p) => presentShown.contains(p.id)).toList();
    final absent = sorted.where((p) => absentShown.contains(p.id)).toList();

    // L'état ne s'écrit que s'il dit quelque chose : ouverte ou passée, rien pour une session à venir.
    final open = session.isOpenAt(now);
    final header = [
      s.page_session_header(timeFormat.format(session.endTime), session.number, timeFormat.format(session.startTime)),
      if (open) s.page_session_state_open,
      if (session.endTime.isBefore(now)) s.page_session_state_past,
    ].join(' — ');
    final unknown = _unknownNumber;

    // Le bouton du champ Numéro : Ajouter (session ouverte ou badgeage manuel), Supprimer en mode suppression.
    final canSubmit = removeMode || open || manualMode;
    void submit() => submitNumber(session, players, canSubmit: canSubmit);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Row(
            children: [
              Text(header, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: 24),
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(s.page_session_manualAdd),
                        Switch(value: manualMode, onChanged: (_) => switchManualMode()),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 160,
                          child: TextField(
                            controller: _numberController,
                            enabled: canSubmit,
                            onChanged: onNumberChanged,
                            onSubmitted: (_) => submit(),
                            keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                            decoration: InputDecoration(
                              labelText: s.page_session_number,
                              isDense: true,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (removeMode) FilledButton.icon(
                          onPressed: canSubmit ? submit : null,
                          icon: const Icon(Icons.delete),
                          label: Text(s.utils_button_delete),
                          style: FilledButton.styleFrom(backgroundColor: error, foregroundColor: Theme.of(context).colorScheme.onError),
                        ),
                        if (!removeMode) FilledButton(
                          onPressed: canSubmit ? submit : null,
                          child: Text(s.utils_button_add),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(s.page_session_removeMode, style: removeMode ? TextStyle(color: error, fontWeight: FontWeight.bold) : null),
                        Switch(
                          value: removeMode,
                          activeThumbColor: error,
                          activeTrackColor: error.withValues(alpha: 0.4),
                          onChanged: (value) => setState(() => removeMode = value),
                        ),
                      ],
                    ),
                    if (unknown != null) Text(s.page_session_number_unknown(unknown), style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Text(DateFormat("Hms", s.localeName).format(now)),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                zone(context, s.page_session_zone_present(present.length), present, present: true),
                zone(context, s.page_session_zone_absent(absent.length), absent, present: false),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      helpLine(context, Colors.grey, s.page_session_help_absent),
                      helpLine(context, null, s.page_session_help_removeMode),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Fait grossir son enfant depuis rien (pop in), ou le fait rétrécir jusqu'à rien (pop out).
class _Pop extends StatefulWidget {
  final Duration duration;
  final bool out;
  final VoidCallback? onDone;
  final Widget child;

  const _Pop({super.key, required this.duration, this.out = false, this.onDone, required this.child});

  @override
  State<_Pop> createState() => _PopState();
}

class _PopState extends State<_Pop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration);
  // Pop in : la bille grossit depuis rien et rebondit au-delà de sa taille (elasticOut).
  // Pop out : elle gonfle un instant, puis rétrécit jusqu'à rien (easeInBack à l'envers).
  late final Animation<double> _scale = Tween<double>(begin: widget.out ? 1 : 0, end: widget.out ? 0 : 1).animate(CurvedAnimation(
    parent: _controller,
    curve: widget.out ? Curves.easeInBack : Curves.elasticOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward().then((_) {
      if (mounted) widget.onDone?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
