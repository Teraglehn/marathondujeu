import 'dart:math';

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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListPage extends ConsumerStatefulWidget       {
  const PlayerListPage({super.key});

  @override
  ConsumerState<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends ConsumerState<PlayerListPage> {

  final TextEditingController _playerCountController = TextEditingController();

  // Chaque sauvegarde fait recharger toute la liste : les clics sur « + » / « − » sont
  // regroupés, la carte réagit tout de suite (setState) et la base suit après une pause.
  final Map<int, Player> _pendingBonus = {};
  final Debouncer _bonusDebouncer = Debouncer(milliseconds: 400);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bonusDebouncer.dispose();
    _flushBonus();
    super.dispose();
  }

  void addBonus(Player player, int delta){
    setState(() => player.bonusSession = max(0, player.bonusSession + delta));

    _pendingBonus[player.id] = player;
    _bonusDebouncer.run(_flushBonus);
  }

  void _flushBonus(){
    if (_pendingBonus.isEmpty) return;
    final players = _pendingBonus.values.toList();
    _pendingBonus.clear();
    ref.read(playerServiceProvider).saveAll(players);
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

    _playerCountController.text = players.asData?.value.length.toString() ?? "100";
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_playerList_title),
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
        onScanned: (player) => editor.editPlayer(player),
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
                    child: TextFormField(
                      controller: _playerCountController,
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: <TextInputFormatter>[FormattersService.integer],
                      decoration: InputDecoration(
                        labelText: S.of(context).page_playerList_playerCount,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).data_event_error_session_duration_minute_required;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () => eventService.generateMissingPlayers(selectedEvent, int.parse(_playerCountController.text)), child: Text(S.of(context).page_playerList_generateMissingPlayers)),
                //ElevatedButton(onPressed: () => eventService.destroyPlayers(selectedEvent), child: Text(S.of(context).page_playerList_deletePlayers))
              ])
            ),
            Expanded(
              child: players.when(
                data: (data) => GridView.extent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: data.map((player) => Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 8,
                    child: InkWell(
                      onTap:() => editor.editPlayer(player),
                      child: Column(children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            child: Text(player.qrcode)
                          ),
                          title: Text(player.name)
                        ),
                        ListTile(
                          leading: countAvatar(context, player.getSessionNumber()),
                          title: Text(S.of(context).data_session_objName(player.getSessionNumber()), style: Theme.of(context).textTheme.bodySmall),
                          dense: true
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
                          dense: true
                        ),
                        ListTile(
                          leading: countAvatar(context, player.getTokenCount()),
                          title: Text(S.of(context).data_player_tokens(player.getTokenCount()), style: Theme.of(context).textTheme.bodySmall),
                          dense: true
                        ),
                      ])
                    )
                  )).toList()
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
