import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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

class _AccountEditFormState extends ConsumerState<PlayerEditForm> implements DirtyAware {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _playerBonusController = TextEditingController();

  // Badgeages manuels en attente : écrits à « Enregistrer », jetés à « Annuler ».
  bool _manualMode = false;
  final Set<int> _sessionsToAdd = {};
  final Set<int> _sessionsToRemove = {};

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

  bool isBadged(Session session) {
    final persisted = session.players.contains(widget.player);
    return persisted ? !_sessionsToRemove.contains(session.id) : _sessionsToAdd.contains(session.id);
  }

  void toggleSession(Session session) {
    final pending = session.players.contains(widget.player) ? _sessionsToRemove : _sessionsToAdd;
    setState(() {
      if (!pending.remove(session.id)) pending.add(session.id);
    });
  }

  void save(){
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.player.bonusSession = _bonus;

    _formKey.currentState!.save();

    // Les badgeages d'abord : c'est l'écriture du joueur qui rafraîchit la liste, elle doit
    // venir en dernier pour que les cartes comptent les nouvelles sessions (L18).
    ref.read(eventServiceProvider)
      .setPlayerSessions(widget.player, added: _sessionsToAdd, removed: _sessionsToRemove)
      .then((_) => ref.read(playersProvider().notifier).save(widget.player))
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void delete(){
    ref.read(playersProvider().notifier)
      .delete(widget.player)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).requestClose(context);
  }

  @override
  bool get isDirty => playerFormIsDirty(widget.player,
    name: _nameKey.currentState?.value ?? widget.player.name,
    bonus: int.tryParse(_playerBonusController.text),
    sessionsToAdd: _sessionsToAdd,
    sessionsToRemove: _sessionsToRemove,
  );

  // Même carte que la liste des sessions ; la bille du numéro passe au vert si le joueur a badgé.
  Widget sessionCard(BuildContext context, Session session) {
    final badged = isBadged(session);
    final scheme = Theme.of(context).colorScheme;
    final timeFormat = DateFormat("Hm", S.of(context).localeName);
    return SizedBox(
      width: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: session.endTime.isBefore(DateTime.now()) ? Colors.grey.shade400 : null,
        elevation: 8,
        child: ListTile(
          onTap: _manualMode ? () => toggleSession(session) : null,
          mouseCursor: _manualMode ? SystemMouseCursors.click : SystemMouseCursors.basic,
          leading: CircleAvatar(
            backgroundColor: badged ? Colors.green : scheme.secondary,
            foregroundColor: badged ? Colors.white : scheme.onSecondary,
            child: Text(session.number.toString()),
          ),
          title: Text(timeFormat.format(session.startTime)),
          subtitle: Text(timeFormat.format(session.endTime)),
        ),
      ),
    );
  }

  // Une ligne de légende : une bille de la couleur donnée (ou rien) et son explication.
  Widget legendLine(BuildContext context, Color? color, String text) {
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
    final eventId = ref.watch(selectedEventProvider).value?.id;
    final sessions = ref.watch(sessionsProvider(eventId: eventId)).value ?? [];
    final sortedSessions = sessions.toList()..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Colonne de gauche : l'image du QR code et, dessous, son code — même largeur.
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: PrettyQrView(qrImage: PlayerCard(code: widget.player.qrcode).getQrImage()),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                readOnly: true,
                                enabled: false,
                                initialValue: widget.player.number.toString(),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: S.of(context).data_player_number,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Colonne de droite : le nom, puis le bonus et son explication.
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                key: _nameKey,
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
                                  const SizedBox(width: 16),
                                  const Icon(Icons.info_outline, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(S.of(context).form_player_bonus_help, style: Theme.of(context).textTheme.bodySmall)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Text(S.of(context).data_session_objName(2), style: Theme.of(context).textTheme.titleMedium),
                        const Spacer(),
                        Text(S.of(context).page_session_manualAdd),
                        const SizedBox(width: 8),
                        Switch(
                          value: _manualMode,
                          onChanged: (value) => setState(() => _manualMode = value),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: sortedSessions.map((session) => sessionCard(context, session)).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        legendLine(context, Colors.green, S.of(context).form_player_legend_present),
                        legendLine(context, Theme.of(context).colorScheme.secondary, S.of(context).form_player_legend_absent),
                        legendLine(context, null, S.of(context).form_player_legend_manual),
                      ],
                    ),
                  ),
                ],
              ),
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
                  child: Text(S.of(context).utils_button_save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
