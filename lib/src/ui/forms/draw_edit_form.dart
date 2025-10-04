import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/draws.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';

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
  int playerCount = 0;

  @override
  void initState(){
    super.initState();
    _minSessionNumberController.text = widget.draw.minSessionNumber.toString();
    _maxSessionNumberController.text = widget.draw.maxSessionNumber.toString();
    _winnerCountController.text = widget.draw.winnerCount.toString();
  }

  void updatePlayerCount(){

    ref.watch(drawServiceProvider)
      .getPlayerCount(widget.draw.event.value!, int.tryParse(_minSessionNumberController.text) ?? 0, int.tryParse(_maxSessionNumberController.text) ?? 0, widget.draw.excludedPlayers, widget.draw.excludedSessions, widget.draw.requiredSessions)
      .then((pcount) => setState(() {
        playerCount = pcount;
      }));
  }

  void save(){
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.draw.minSessionNumber = int.tryParse(_minSessionNumberController.text) ?? 0;
    widget.draw.maxSessionNumber = int.tryParse(_maxSessionNumberController.text) ?? 0;
    widget.draw.winnerCount = int.tryParse(_winnerCountController.text) ?? 1;

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
            child: ListTile(
              leading: CircleAvatar(
                child: Text(playerCount.toString())
              ),
              title: Text(S.of(context).data_draw_playerCount(playerCount)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.allowRemove) TextButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: Text(S.of(context).utils_button_delete),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: cancel,
                  label: Text(S.of(context).utils_button_cancel),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextButton.icon(
                  onPressed: save,
                  label: Text(S.of(context).utils_button_save_and_draw),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}