import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListPage extends ConsumerStatefulWidget       {
  const PlayerListPage({super.key});

  @override
  ConsumerState<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends ConsumerState<PlayerListPage> {

  final TextEditingController _playerCountController = TextEditingController(text : "100");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.read(editorPodProvider.notifier);
    final selectedEvent = ref.watch(selectedEventProvider);
    final players = ref.watch(playersProvider(eventId: selectedEvent.value?.id));
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    final eventService = ref.watch(eventServiceProvider);
    
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
      body: EventSelectedGuard(builder: (selectedEvent) => Column(
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
                      labelText: S.of(context).data_event_session_duration_minute,
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
              ElevatedButton(onPressed: () => eventService.generatePlayers(selectedEvent, int.parse(_playerCountController.text)), child: const Text("generate players")),
              ElevatedButton(onPressed: () => eventService.destroyPlayers(selectedEvent), child: const Text("destroy players"))
            ])
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              int columns = (constraints.maxWidth / 150).floor();
              return players.when(
                data: (data) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns, // Number of columns
                    crossAxisSpacing: 10,   // Space between columns
                    mainAxisSpacing: 10,    // Space between rows
                  ),
                  itemCount: data.length, // Total number of items
                  itemBuilder: (context, index) {
                    Player player = data[index];
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 8,
                      child: InkWell(
                        onTap:() => editor.editPlayer(player),
                        child: Column(children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            child: Text(player.name)
                          ),
                          Text("Nb of session : ${player.sessions.toSet().length}"),
                          Text("Nb of Bonus : ${player.bonusSession}"),
                          Text("total token : ${player.getTokenNumber()}"),
                        ])
                      )
                    );
                  },
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink()
              );
            }),
          ),
        ],
      )),
      floatingActionButton: selectedEvent.value == null ? null : FloatingActionButton(
        onPressed: () => editor.editPlayer(null),
        child: const Icon(Icons.add),
      )
    );
  }
}
