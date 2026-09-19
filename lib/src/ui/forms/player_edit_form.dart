import 'dart:math';

import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';

class PlayerEditForm extends ConsumerStatefulWidget {

  final Player player;

  final bool allowRemove;

  const PlayerEditForm(
    this.player, 
    {
      this.allowRemove = true,
      super.key,
    });

  @override
  ConsumerState<PlayerEditForm> createState() => _AccountEditFormState();
}

class _AccountEditFormState extends ConsumerState<PlayerEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _playerBonusController = TextEditingController();

  @override
  void initState(){
    super.initState();

    _playerBonusController.text = widget.player.bonusSession.toString();
  }

  int get _bonus => int.tryParse(_playerBonusController.text) ?? 0;

  void addBonus(int delta){
    setState(() {
      _playerBonusController.text = max(0, _bonus + delta).toString();
    });
  }

  void save(){
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.player.bonusSession = _bonus;

    _formKey.currentState!.save();
    
    ref.read(playersProvider().notifier)
      .save(widget.player)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void delete(){
    ref.read(playersProvider().notifier)
      .delete(widget.player)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).close();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.player.name,
              decoration: InputDecoration(
                labelText: S.of(context).data_player_name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_player_error_name_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.player.name = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true,
              initialValue: widget.player.qrcode,
              decoration: InputDecoration(
                labelText: S.of(context).data_player_qrcode,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_player_error_qrCode_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.player.qrcode = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: _playerBonusController,
                    keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                    inputFormatters: <TextInputFormatter>[FormattersService.integer],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: S.of(context).data_player_bonus,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(onPressed: _bonus > 0 ? () => addBonus(-1) : null, icon: const Icon(Icons.remove), mouseCursor: SystemMouseCursors.click),
                const SizedBox(width: 8),
                IconButton.filledTonal(onPressed: () => addBonus(1), icon: const Icon(Icons.add), mouseCursor: SystemMouseCursors.click),
              ],
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
                  label: Text(S.of(context).utils_button_save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}