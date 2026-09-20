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
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListPage extends ConsumerStatefulWidget       {
  const PlayerListPage({super.key});

  @override
  ConsumerState<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends ConsumerState<PlayerListPage> {

  // La carte d'un joueur : la ligne du nom (dense, 48 px), trois lignes compactes (40 px), les
  // marges de la Card.
  static const double _cardWidth = 200;
  static const double _cardHeight = 48 + 3 * 40 + 8;

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

  Widget bonusButton(IconData icon, VoidCallback? onPressed) => IconButton.filledTonal(
    onPressed: onPressed,
    icon: Icon(icon, size: 16),
    padding: EdgeInsets.zero,
    mouseCursor: SystemMouseCursors.click,
    constraints: const BoxConstraints.tightFor(width: 28, height: 28),
  );

  // Bille de compteur : grisée à zéro.
  Widget countAvatar(BuildContext context, int count) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 12,
      backgroundColor: count == 0 ? scheme.surfaceContainerHighest : null,
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: count == 0 ? scheme.outline : null),
      ),
    );
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
          const ScanStatus(),
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
        child: Column(
          children: [
            Container(
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
                  children: data.map((player) => SizedBox(
                  width: _cardWidth,
                  height: _cardHeight,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 8,
                    child: InkWell(
                      onTap:() => editor.editPlayer(player),
                      child: Column(children: [
                        ListTile(
                          // Sans jeton, le joueur n'est pas dans l'urne : sa bille est grise.
                          leading: CircleAvatar(
                            backgroundColor: player.getTokenCount() == 0 ? Theme.of(context).colorScheme.surfaceContainerHighest : Theme.of(context).colorScheme.primary,
                            foregroundColor: player.getTokenCount() == 0 ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.onPrimary,
                            child: Text(player.number.toString())
                          ),
                          title: Text(player.name),
                          dense: true
                        ),
                        ListTile(
                          leading: countAvatar(context, player.getSessionNumber()),
                          title: Text(S.of(context).data_session_objName(player.getSessionNumber()), style: Theme.of(context).textTheme.bodySmall),
                          dense: true,
                          visualDensity: VisualDensity.compact
                        ),
                        ListTile(
                          leading: countAvatar(context, player.bonusSession),
                          title: Text(S.of(context).data_player_bonus, style: Theme.of(context).textTheme.bodySmall),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              bonusButton(Icons.remove, player.bonusSession > 0 ? () => addBonus(player, -1) : null),
                              bonusButton(Icons.add, () => addBonus(player, 1)),
                            ],
                          ),
                          dense: true,
                          visualDensity: VisualDensity.compact
                        ),
                        ListTile(
                          leading: countAvatar(context, player.getTokenCount()),
                          title: Text(S.of(context).data_player_tokens(player.getTokenCount()), style: Theme.of(context).textTheme.bodySmall),
                          dense: true,
                          visualDensity: VisualDensity.compact
                        ),
                      ])
                    )
                  ))).toList()
                  ),
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              )
            ),
          ],
        )
      ))
    );
  }
}
