import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/draws.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/widgets/fields/player_group_selector.dart';
import 'package:marathondujeu/src/ui/widgets/fields/session_multi_selector.dart';

class DrawEditForm extends ConsumerStatefulWidget {

  final Draw draw;

  final bool allowRemove;

  const DrawEditForm(
    this.draw, 
    {
      this.allowRemove = true,
      super.key,
    });

  @override
  ConsumerState<DrawEditForm> createState() => _DrawEditFormState();
}

class _DrawEditFormState extends ConsumerState<DrawEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _minSessionNumberController = TextEditingController();
  final _maxSessionNumberController = TextEditingController();
  final _winnerCountController = TextEditingController();
  final Set<Player> excludedPlayer = {};
  Set<PlayerGroup> excludedPlayerGroup = {};
  final Set<Player> requiredPlayer = {};
  Set<PlayerGroup> requiredPlayerGroup = {};
  final Set<Session> requiredSessions = {};
  final Set<Session> excludedSessions = {};
  int playerCount = 0;

  @override
  void initState(){
    super.initState();
    _minSessionNumberController.text = widget.draw.minSessionNumber.toString();
    _maxSessionNumberController.text = widget.draw.maxSessionNumber.toString();
    _winnerCountController.text = widget.draw.winnerCount.toString();
  }

  void updatePlayerCount(){
    excludedPlayer.clear();
    excludedPlayer.addAll(excludedPlayerGroup.fold<Set<Player>>({}, (ep, pg) => ep..addAll(pg.players)));
    requiredPlayer.clear();
    requiredPlayer.addAll(requiredPlayerGroup.fold<Set<Player>>({}, (ep, pg) => ep..addAll(pg.players)));

    ref.watch(drawServiceProvider)
      .getPlayerCount(widget.draw.event.value!, int.tryParse(_minSessionNumberController.text) ?? 0, int.tryParse(_maxSessionNumberController.text) ?? 0, excludedPlayer, requiredPlayer, excludedSessions, requiredSessions)
      .then((pcount) => setState(() {
        playerCount = pcount;
      }));
  }

  void save(){
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.draw.excludedPlayers.clear();
    widget.draw.requiredPlayers.clear();
    widget.draw.excludedSessions.clear();
    widget.draw.requiredSessions.clear();

    widget.draw.minSessionNumber = int.tryParse(_minSessionNumberController.text) ?? 0;
    widget.draw.maxSessionNumber = int.tryParse(_maxSessionNumberController.text) ?? 0;
    widget.draw.winnerCount = int.tryParse(_winnerCountController.text) ?? 1;
    widget.draw.excludedPlayers.addAll(excludedPlayerGroup.fold<Set<Player>>({}, (ep, pg) => ep..addAll(pg.players)));
    widget.draw.requiredPlayers.addAll(requiredPlayerGroup.fold<Set<Player>>({}, (ep, pg) => ep..addAll(pg.players)));
    widget.draw.excludedSessions.addAll(excludedSessions);
    widget.draw.requiredSessions.addAll(requiredSessions);

    _formKey.currentState!.save();
    
    ref.read(drawsProvider().notifier)
      .save(widget.draw)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void delete(){
    ref.read(drawsProvider().notifier)
      .delete(widget.draw)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).close();
  }

  @override
  Widget build(BuildContext context) {
    updatePlayerCount();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.draw.name,
              decoration: InputDecoration(
                labelText: S.of(context).data_draw_name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_draw_error_name_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.draw.name = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _minSessionNumberController,
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              inputFormatters: <TextInputFormatter>[FormattersService.integer],
              decoration: InputDecoration(
                labelText: S.of(context).data_draw_minSessionNumber,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => updatePlayerCount(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _maxSessionNumberController,
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              inputFormatters: <TextInputFormatter>[FormattersService.integer],
              decoration: InputDecoration(
                labelText: S.of(context).data_draw_maxSessionNumber,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => updatePlayerCount(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _winnerCountController,
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              inputFormatters: <TextInputFormatter>[FormattersService.integer],
              decoration: InputDecoration(
                labelText: S.of(context).data_draw_winnerCount,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlayerGroupSelector(
              label: S.of(context).data_draw_excludedPlayers,
              event: widget.draw.event.value!,
              onChanged: (pg) {
                excludedPlayerGroup = pg;
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlayerGroupSelector(
              label: S.of(context).data_draw_requiredPlayers,
              event: widget.draw.event.value!,
              onChanged: (pg) {
                requiredPlayerGroup = pg;
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SessionMultiSelector(
              label: S.of(context).data_draw_excludedSessions,
              event: widget.draw.event.value!,
              onChanged: (sessions) {
                excludedSessions.clear();
                excludedSessions.addAll(sessions);
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SessionMultiSelector(
              initialValue: {widget.draw.event.value!.sessions.last},
              label: S.of(context).data_draw_requiredSessions,
              event: widget.draw.event.value!,
              onChanged: (sessions) {
                requiredSessions.clear();
                requiredSessions.addAll(sessions);
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(playerCount.toString())
              ),
              title: Text(S.of(context).data_draw_playerCount(playerCount)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.allowRemove) FilledButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: Text(S.of(context).utils_button_delete),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    minimumSize: const Size(0, 48),
                  ),
                ),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: cancel,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(S.of(context).utils_button_cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(S.of(context).utils_button_save_and_draw),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}