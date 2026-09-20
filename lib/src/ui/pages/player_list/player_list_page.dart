import 'dart:math';
import 'dart:ui' show AppExitResponse;

import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/services/debouncer.service.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/player_list_card.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListPage extends ConsumerStatefulWidget       {
  const PlayerListPage({super.key});

  @override
  ConsumerState<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends ConsumerState<PlayerListPage> {

  // Les cibles de l'aide de la page (L12).
  final _countKey = GlobalKey();
  final _firstKey = GlobalKey();
  final _legendKey = GlobalKey();
  final _scanKey = GlobalKey();

  // Le pas à pas : la première carte quand il y en a une, sinon un pas qui dit où elles viendront.
  List<HelpStep> helpSteps() {
    final s = S.of(context);
    final empty = _shownCount == 0;
    return [
      HelpStep(s.help_playerList_1),
      HelpStep(s.help_playerList_2, target: _countKey),
      if (empty) HelpStep(s.help_playerList_3_empty),
      if (!empty) ...[
        HelpStep(s.help_playerList_3, target: _firstKey),
        HelpStep(s.help_playerList_4, target: _firstKey),
      ],
      HelpStep(s.help_playerList_5, target: _legendKey),
      HelpStep(s.help_playerList_6, target: _scanKey),
    ];
  }

  final TextEditingController _playerCountController = TextEditingController();
  // Le nombre de joueurs qui a rempli le champ : il se remplit à nouveau quand il change.
  int? _shownCount;

  // Chaque sauvegarde fait recharger toute la liste : les clics sur « + » / « − » sont
  // regroupés, la carte réagit tout de suite (setState) et la base suit après une pause.
  final Map<int, Player> _pendingBonus = {};
  final Debouncer _bonusDebouncer = Debouncer(milliseconds: 400);
  // Fermer l'application pendant la pause retient la fermeture le temps d'écrire.
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onExitRequested: _onExitRequested);
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _bonusDebouncer.dispose();
    _flushBonus();
    super.dispose();
  }

  void addBonus(Player player, int delta){
    setState(() => player.bonusSession = max(0, player.bonusSession + delta));

    _pendingBonus[player.id] = player;
    _bonusDebouncer.run(_flushBonus);
  }

  Future<void> _flushBonus(){
    if (_pendingBonus.isEmpty) return Future.value();
    final players = _pendingBonus.values.toList();
    _pendingBonus.clear();
    return ref.read(playerServiceProvider).saveAll(players);
  }

  Future<AppExitResponse> _onExitRequested() async {
    _bonusDebouncer.dispose();
    await _flushBonus();
    return AppExitResponse.exit;
  }

  // Le nombre saisi n'ajoute des joueurs que s'il dépasse les existants.
  bool canGenerate(int existing) {
    final requested = int.tryParse(_playerCountController.text);
    return requested != null && requested > existing;
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.read(editorPodProvider.notifier);
    final selectedEvent = ref.watch(selectedEventProvider);
    final players = ref.watch(playersProvider(eventId: selectedEvent.value?.id));
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    final eventService = ref.watch(eventServiceProvider);

    final existing = players.asData?.value.length ?? 0;
    if (existing != _shownCount) {
      _shownCount = existing;
      _playerCountController.text = existing.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_playerList_title),
        actions: [
          ScanStatus(key: _scanKey),
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
        child: Column(
          children: [
            Container(
              key: _countKey,
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(children: [
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // La clé remet le champ à neuf quand le nombre de joueurs change : pas
                    // d'erreur affichée tant qu'on n'a rien saisi.
                    child: TextFormField(
                      key: ValueKey(existing),
                      controller: _playerCountController,
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: <TextInputFormatter>[FormattersService.integer],
                      decoration: InputDecoration(
                        labelText: S.of(context).page_playerList_playerCount,
                        border: const OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).data_event_error_session_duration_minute_required;
                        }
                        if (!canGenerate(existing)) {
                          return S.of(context).page_playerList_alreadyExisting(existing);
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: canGenerate(existing) ? () => eventService.generateMissingPlayers(selectedEvent, int.parse(_playerCountController.text)) : null,
                  child: Text(S.of(context).page_playerList_generateMissingPlayers),
                ),
                HelpHint(S.of(context).help_hint_playerCount),
                //ElevatedButton(onPressed: () => eventService.destroyPlayers(selectedEvent), child: Text(S.of(context).page_playerList_deletePlayers))
              ])
            ),
            Expanded(
              child: players.when(
                // Des cartes de taille fixe, qui se rangent en lignes : une grille répartirait la
                // largeur et, trop étroite, ferait déborder la ligne Bonus et ses boutons (L18).
                data: (data) => SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: data.map((player) => PlayerListCard.of(
                    player,
                    key: player == data.first ? _firstKey : null,
                    onTap: () => editor.editPlayer(player),
                    onBonus: (delta) => addBonus(player, delta),
                  )).toList()
                  ),
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              )
            ),
            Container(
              key: _legendKey,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlayerListCard.countAvatar(context, 0),
                  const SizedBox(width: 8),
                  Expanded(child: Text(S.of(context).page_playerList_legend, style: Theme.of(context).textTheme.bodySmall)),
                ],
              ),
            ),
          ],
        )
      ))
    );
  }
}
