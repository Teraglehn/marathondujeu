import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';
import 'package:marathondujeu/src/ui/widgets/fields/datetime_form_field.dart';
import 'package:marathondujeu/src/ui/widgets/toast.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:uuid/uuid.dart';

class EventEditForm extends ConsumerStatefulWidget {

  final Event event;

  final bool allowRemove;

  const EventEditForm(
    this.event, 
    {
      this.allowRemove = true,
      super.key,
    });

  @override
  ConsumerState<EventEditForm> createState() => _EventEditFormState();
}

class _EventEditFormState extends ConsumerState<EventEditForm> implements DirtyAware {
  final _formKey = GlobalKey<FormState>();
  // Clés des champs à `initialValue` : pour relire leur valeur (`isDirty`).
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _startKey = GlobalKey<FormFieldState<DateTime>>();
  final _endKey = GlobalKey<FormFieldState<DateTime>>();
  final _sessionTimeMinuteController = TextEditingController();
  final _sessionIntervalMinuteController = TextEditingController();

  // La protection des cartes : un sel propre à l'événement dans le QR code. Jamais saisi.
  late String _qrSalt;

  @override
  void initState(){
    super.initState();
    _qrSalt = widget.event.qrSalt;
    _sessionTimeMinuteController.text = widget.event.sessionTimeMinutes.toString();
    _sessionIntervalMinuteController.text = widget.event.sessionIntervalMinutes.toString();
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Les paramètres de session ont changé → les sessions sont recréées ; avec des badgeages,
    // on demande d'abord (L19). Un événement neuf reçoit ses sessions du service.
    final regenerateSessions = widget.event.exist && eventSessionsChanged(widget.event,
      start: _startKey.currentState?.value,
      end: _endKey.currentState?.value,
      sessionTime: int.tryParse(_sessionTimeMinuteController.text),
      sessionInterval: int.tryParse(_sessionIntervalMinuteController.text),
    );
    if (regenerateSessions && !await confirmRegenerateSessions()) return;

    widget.event.sessionTimeMinutes = int.parse(_sessionTimeMinuteController.text);
    widget.event.sessionIntervalMinutes = int.parse(_sessionIntervalMinuteController.text);
    widget.event.qrSalt = _qrSalt;

    _formKey.currentState!.save();

    ref.read(eventsProvider().notifier)
      .save(widget.event, regenerateSessions: regenerateSessions)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  /// Remet début, fin, durée et intervalle à leur valeur enregistrée ; le reste de l'éditeur
  /// garde ses modifications.
  void resetSessionParams() {
    _startKey.currentState?.reset();
    _endKey.currentState?.reset();
    _sessionTimeMinuteController.text = widget.event.sessionTimeMinutes.toString();
    _sessionIntervalMinuteController.text = widget.event.sessionIntervalMinutes.toString();
  }

  void delete(){
    ref.read(eventsProvider().notifier)
      .delete(widget.event)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).requestClose(context);
  }

  @override
  bool get isDirty => eventFormIsDirty(widget.event,
    name: _nameKey.currentState?.value ?? widget.event.name,
    start: _startKey.currentState?.value,
    end: _endKey.currentState?.value,
    sessionTime: int.tryParse(_sessionTimeMinuteController.text),
    sessionInterval: int.tryParse(_sessionIntervalMinuteController.text),
    qrSalt: _qrSalt,
  );

  void setProtected(bool protected) {
    setState(() => _qrSalt = protected ? const Uuid().v4().substring(0, 8) : '');
  }

  /// Retrouve le sel depuis une carte imprimée : ce qui précède le dernier « - » du code scanné.
  Future<void> recoverSalt() async {
    final salt = await showDialog<String>(
      context: context,
      builder: (context) => BarcodeKeyboardListener(
        useKeyDownEvent: true,
        onBarcodeScanned: (code) => Navigator.of(context).pop(Event.saltFromCode(code.trim())),
        child: AlertDialog(
          title: Text(S.of(context).data_event_recoverSalt),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.qr_code_scanner, size: 32),
              const SizedBox(width: 16),
              Text(S.of(context).data_event_recoverSalt_scan),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(S.of(context).utils_button_cancel)),
          ],
        ),
      ),
    );
    if (salt == null || !mounted) return;
    if (salt.isEmpty) {
      Toast.show(context, S.of(context).data_event_recoverSalt_none, error: true);
      return;
    }
    setState(() => _qrSalt = salt);
  }

  /// Recréer les sessions perd leurs badgeages : s'il y en a, on le dit et on demande.
  /// Refusé → les paramètres de session reprennent leur valeur enregistrée, l'éditeur reste ouvert.
  Future<bool> confirmRegenerateSessions() async {
    final badges = await ref.read(eventServiceProvider).countBadges(widget.event);
    if (badges == 0 || !mounted) return true;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).data_event_regenerateSessions_title),
        content: Text(S.of(context).data_event_regenerateSessions_confirm(badges)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(S.of(context).data_event_regenerateSessions_revert)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(S.of(context).data_event_regenerateSessions_recreate)),
        ],
      ),
    );
    if (confirmed == true) return true;
    if (mounted) resetSessionParams();
    return false;
  }

  /// Supprime tous les joueurs de l'événement, après confirmation : c'est ce qui débloque la protection.
  Future<void> deletePlayers(int count) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).page_playerList_deletePlayers),
        content: Text(S.of(context).data_event_deletePlayers_confirm(count)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(S.of(context).utils_button_cancel)),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error, foregroundColor: Theme.of(context).colorScheme.onError),
            child: Text(S.of(context).utils_button_delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(eventServiceProvider).destroyPlayers(widget.event);
  }

  /// Le bloc « Protéger les cartes » : interrupteur, explication, récupération ; verrouillé dès
  /// que des joueurs existent.
  Widget protectionBlock(BuildContext context, int playerCount) {
    final hasPlayers = playerCount > 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text(S.of(context).data_event_protectCards),
            subtitle: Text(hasPlayers ? S.of(context).data_event_protectCards_locked : S.of(context).data_event_protectCards_help),
            value: _qrSalt.isNotEmpty,
            onChanged: hasPlayers ? null : setProtected,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: hasPlayers
              ? TextButton.icon(
                  onPressed: () => deletePlayers(playerCount),
                  icon: const Icon(Icons.delete),
                  label: Text(S.of(context).page_playerList_deletePlayers),
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                )
              : TextButton.icon(
                  onPressed: recoverSalt,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: Text(S.of(context).data_event_recoverSalt),
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Un événement pas encore enregistré n'a pas de joueur.
    final playerCount = widget.event.exist
      ? (ref.watch(playersProvider(eventId: widget.event.id)).value?.length ?? 0)
      : 0;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: _nameKey,
                      initialValue: widget.event.name,
                      decoration: InputDecoration(
                        labelText: S.of(context).data_event_name,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).data_event_error_name_required;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.event.name = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      key: _startKey,
                      initialValue: widget.event.startDateTime,
                      label: S.of(context).data_event_datetime_start,
                      validator: (value) {
                        if (value == null) {
                          return S.of(context).data_event_error_datetime_start_required;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.event.startDateTime = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      key: _endKey,
                      initialValue: widget.event.endDateTime,
                      label: S.of(context).data_event_datetime_end,
                      validator: (value) {
                        if (value == null) {
                          return S.of(context).data_event_error_datetime_end_required;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.event.endDateTime = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _sessionTimeMinuteController,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _sessionIntervalMinuteController,
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: <TextInputFormatter>[FormattersService.integer],
                      decoration: InputDecoration(
                        labelText: S.of(context).data_event_session_interval_minute,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).data_event_error_session_interval_minute_required;
                        }
                        return null;
                      },
                    ),
                  ),
                  protectionBlock(context, playerCount),
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