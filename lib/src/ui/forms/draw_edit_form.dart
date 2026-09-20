import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/player_groups.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/forms/dirty_aware.dart';
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

class _DrawEditFormState extends ConsumerState<DrawEditForm> implements DirtyAware {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _minSessionNumberController = TextEditingController();
  final _maxSessionNumberController = TextEditingController();
  final _winnerCountController = TextEditingController();

  // Les choix de l'éditeur, chargés depuis le tirage ; les groupes sont résolus au tirage.
  Set<PlayerGroup> excludedGroups = {};
  Set<PlayerGroup> requiredGroups = {};
  final Set<Session> requiredSessions = {};
  final Set<Session> excludedSessions = {};
  int playerCount = 0;
  int tokenCount = 0;
  bool loaded = false;

  // Un tirage effectué ne se modifie plus et ne se relance pas.
  bool get readOnly => widget.draw.isDrawn;

  @override
  void initState(){
    super.initState();
    _minSessionNumberController.text = widget.draw.minSessionNumber.toString();
    _maxSessionNumberController.text = widget.draw.maxSessionNumber.toString();
    _winnerCountController.text = widget.draw.winnerCount.toString();
    load();
  }

  Future<void> load() async {
    final draw = widget.draw;
    // Un tirage pas encore enregistré (neuf, ou copie) n'a pas de liens en base : ses choix
    // sont déjà en mémoire.
    if (draw.exist) {
      await Future.wait([
        draw.excludedGroups.load(),
        draw.requiredGroups.load(),
        draw.excludedSessions.load(),
        draw.requiredSessions.load(),
        draw.excludedPlayers.load(),
        draw.requiredPlayers.load(),
      ]);
    }
    excludedGroups = Draw.linked(draw.excludedGroups);
    requiredGroups = Draw.linked(draw.requiredGroups);
    excludedSessions.addAll(Draw.linked(draw.excludedSessions));
    requiredSessions.addAll(Draw.linked(draw.requiredSessions));
    if (!mounted) return;
    setState(() => loaded = true);
    updatePlayerCount();
  }

  void updatePlayerCount(){
    ref.read(drawServiceProvider)
      .getEligibilityFor(
        widget.draw.event.value!,
        minSessionNumber: int.tryParse(_minSessionNumberController.text) ?? 0,
        maxSessionNumber: int.tryParse(_maxSessionNumberController.text) ?? 0,
        excludedPlayers: Draw.linked(widget.draw.excludedPlayers),
        requiredPlayers: Draw.linked(widget.draw.requiredPlayers),
        excludedGroups: excludedGroups,
        requiredGroups: requiredGroups,
        excludedSessions: excludedSessions,
        requiredSessions: requiredSessions,
      )
      .then((e) { if (mounted) setState(() { playerCount = e.players; tokenCount = e.tokens; }); });
  }

  /// Reporte les choix de l'écran sur le tirage ; vrai si le formulaire est valide.
  bool applyToDraw(){
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    widget.draw.minSessionNumber = int.tryParse(_minSessionNumberController.text) ?? 0;
    widget.draw.maxSessionNumber = int.tryParse(_maxSessionNumberController.text) ?? 0;
    widget.draw.winnerCount = int.tryParse(_winnerCountController.text) ?? 1;
    widget.draw.excludedGroups
      ..clear()
      ..addAll(excludedGroups);
    widget.draw.requiredGroups
      ..clear()
      ..addAll(requiredGroups);
    widget.draw.excludedSessions
      ..clear()
      ..addAll(excludedSessions);
    widget.draw.requiredSessions
      ..clear()
      ..addAll(requiredSessions);

    _formKey.currentState!.save();
    return true;
  }

  void save(){
    if (!applyToDraw()) return;
    ref.read(drawServiceProvider)
      .save(widget.draw)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  Future<void> launch() async {
    if (!applyToDraw()) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).data_draw_launch),
        content: Text(S.of(context).data_draw_launch_confirm(widget.draw.winnerCount, playerCount)),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(S.of(context).utils_button_cancel)),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: Text(S.of(context).data_draw_launch)),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(drawServiceProvider).launch(widget.draw);
    ref.read(editorPodProvider.notifier).close();
  }

  /// Ouvre l'éditeur sur une copie, non enregistrée.
  Future<void> copy() async {
    final copy = await ref.read(drawServiceProvider).createDrawFromDraw(widget.draw);
    ref.read(editorPodProvider.notifier).editDraw(copy);
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).requestClose(context);
  }

  /// Un tirage effectué ne se modifie pas ; avant le chargement, rien n'a pu l'être.
  @override
  bool get isDirty => loaded && !readOnly && drawFormIsDirty(widget.draw,
    name: _nameKey.currentState?.value ?? widget.draw.name,
    winnerCount: int.tryParse(_winnerCountController.text),
    minSessionNumber: int.tryParse(_minSessionNumberController.text),
    maxSessionNumber: int.tryParse(_maxSessionNumberController.text),
    excludedGroups: excludedGroups,
    requiredGroups: requiredGroups,
    excludedSessions: excludedSessions,
    requiredSessions: requiredSessions,
  );

  Widget help(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
      ],
    ),
  );

  Widget intField(TextEditingController controller, String label) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      enabled: !readOnly,
      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
      inputFormatters: <TextInputFormatter>[FormattersService.integer],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => updatePlayerCount(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final draw = widget.draw;
    final event = draw.event.value!;
    // Groupes et sessions lus ici, dans `build` : les sélecteurs les recevraient sinon d'un pod
    // à disposition automatique que personne ne regarde sur cette page — détruit pendant son
    // chargement, il ne répond jamais (L18).
    final groups = ref.watch(playerGroupsProvider(eventId: event.id)).value;
    final sessions = ref.watch(sessionsProvider(eventId: event.id)).value;
    if (!loaded) return const Center(child: CircularProgressIndicator());

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (readOnly) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: Text(draw.drawnAt != null
                        ? S.of(context).data_draw_drawnAt(DateFormat.yMd(S.of(context).localeName).add_Hm().format(draw.drawnAt!))
                        : S.of(context).data_draw_drawn),
                      subtitle: Text(S.of(context).data_draw_drawn_help),
                      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: _nameKey,
                      initialValue: draw.name,
                      enabled: !readOnly,
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
                        draw.name = value!;
                      },
                    ),
                  ),
                  intField(_winnerCountController, S.of(context).data_draw_winnerCount),
                  Row(children: [
                    Expanded(child: intField(_minSessionNumberController, S.of(context).data_draw_minSessionNumber)),
                    Expanded(child: intField(_maxSessionNumberController, S.of(context).data_draw_maxSessionNumber)),
                  ]),
                  Row(children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlayerGroupSelector(
                      label: S.of(context).data_draw_excludedPlayers,
                      event: event,
                      groups: groups,
                      readOnly: readOnly,
                      initialValue: excludedGroups,
                      onChanged: (pg) {
                        excludedGroups = pg;
                        updatePlayerCount();
                      },
                      ),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlayerGroupSelector(
                      label: S.of(context).data_draw_requiredPlayers,
                      event: event,
                      groups: groups,
                      readOnly: readOnly,
                      initialValue: requiredGroups,
                      onChanged: (pg) {
                        requiredGroups = pg;
                        updatePlayerCount();
                      },
                      ),
                    )),
                  ]),
                  if (Draw.linked(draw.excludedPlayers).isNotEmpty)
                    help(context, S.of(context).data_draw_excludedPlayers_count(Draw.linked(draw.excludedPlayers).length)),
                  Row(children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SessionMultiSelector(
                      label: S.of(context).data_draw_excludedSessions,
                      event: event,
                      sessions: sessions,
                      readOnly: readOnly,
                      initialValue: excludedSessions.toSet(),
                      onChanged: (sessions) {
                        excludedSessions
                          ..clear()
                          ..addAll(sessions);
                        updatePlayerCount();
                      },
                      ),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SessionMultiSelector(
                      label: S.of(context).data_draw_requiredSessions,
                      event: event,
                      sessions: sessions,
                      readOnly: readOnly,
                      initialValue: requiredSessions.toSet(),
                      onChanged: (sessions) {
                        requiredSessions
                          ..clear()
                          ..addAll(sessions);
                        updatePlayerCount();
                      },
                      ),
                    )),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(playerCount.toString())),
                            title: Text(S.of(context).data_draw_playerCount(playerCount)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(tokenCount.toString())),
                            title: Text(S.of(context).data_draw_tokenCount(tokenCount)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  help(context, S.of(context).data_draw_eligibility_help),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonal(
                  onPressed: cancel,
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: Text(readOnly ? S.of(context).utils_button_close : S.of(context).utils_button_cancel),
                ),
                const SizedBox(width: 8),
                if (readOnly) FilledButton.icon(
                  onPressed: copy,
                  icon: const Icon(Icons.copy),
                  label: Text(S.of(context).data_draw_copy),
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                ) else ...[
                  FilledButton.tonal(
                    onPressed: save,
                    style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                    child: Text(S.of(context).utils_button_save),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: launch,
                    icon: const Icon(Icons.casino),
                    label: Text(S.of(context).data_draw_launch),
                    style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
