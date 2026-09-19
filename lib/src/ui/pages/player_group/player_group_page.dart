import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_player_group.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/player_bubble.dart';

class PlayerGroupPage extends ConsumerStatefulWidget {

  const PlayerGroupPage({super.key});

  @override
  ConsumerState<PlayerGroupPage> createState() => _PlayerGroupPageState();
}

class _PlayerGroupPageState extends ConsumerState<PlayerGroupPage> {
  static const _numberIdle = Duration(seconds: 2);

  bool removeMode = false;
  final _numberController = TextEditingController();
  // Le dernier numéro validé qui n'a pas été ajouté, et pourquoi : inconnu, ou déjà membre.
  int? _unknownNumber;
  int? _alreadyMemberNumber;
  // Deux secondes sans saisie : le champ rend le focus à la douchette (comme la page d'une session).
  Timer? _numberIdleTimer;

  @override
  void dispose() {
    _numberIdleTimer?.cancel();
    _numberController.dispose();
    super.dispose();
  }

  void releaseNumberField({bool clear = false}) {
    _numberIdleTimer?.cancel();
    if (clear) _numberController.clear();
    FocusScope.of(context).unfocus();
  }

  // Une saisie qui n'est pas que des chiffres vient de la douchette : le champ se vide et rend
  // la main, l'écouteur de la douchette fait l'ajout.
  void onNumberChanged(String text) {
    if (int.tryParse(text) == null && text.isNotEmpty) {
      releaseNumberField(clear: true);
      return;
    }
    _numberIdleTimer?.cancel();
    _numberIdleTimer = Timer(_numberIdle, () {
      if (mounted) releaseNumberField();
    });
  }

  // Entrée ou le bouton : ajoute le joueur de ce numéro. Le champ se vide s'il est ajouté.
  Future<void> submitNumber(PlayerGroup group, List<Player> players) async {
    releaseNumberField();
    final number = int.tryParse(_numberController.text);
    if (number == null) return;

    final player = players.where((p) => p.number == number).firstOrNull;
    if (player == null) {
      setState(() { _unknownNumber = number; _alreadyMemberNumber = null; });
      return;
    }
    final added = await ref.read(playerGroupServiceProvider).addPlayer(group, player);
    if (!mounted) return;
    setState(() { _unknownNumber = null; _alreadyMemberNumber = added ? null : number; });
    if (added) _numberController.clear();
  }

  void remove(PlayerGroup group, Player player) {
    ref.read(playerGroupServiceProvider).removePlayer(group, player);
  }

  Widget bubble(BuildContext context, PlayerGroup group, Player player) {
    final bubble = PlayerBubble(
      number: player.number,
      color: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    if (!removeMode) return bubble;
    return RemovableBubble(bubble: bubble, label: S.of(context).page_session_remove, onRemove: () => remove(group, player));
  }

  @override
  Widget build(BuildContext context) {
    final selectedGroup = ref.watch(selectedPlayerGroupProvider);
    final group = selectedGroup.value;
    final groupService = ref.watch(playerGroupServiceProvider);
    final selectedEvent = ref.watch(selectedEventProvider);
    final players = ref.watch(playersProvider(eventId: selectedEvent.value?.id)).value ?? [];

    // Le groupe vient d'être supprimé depuis son éditeur : retour à la liste.
    ref.listen(selectedPlayerGroupProvider, (previous, next) {
      if (previous?.value != null && next.hasValue && next.value == null) {
        GoRouter.of(context).goNamed(Routes.playerGroupList);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).goNamed(Routes.playerGroupList),
          icon: const Icon(Icons.arrow_back)
        ),
        title: Text("${S.of(context).page_playerGroup_title} : ${group?.name ?? ''}"),
        actions: [
          if (group != null) IconButton(
            onPressed: () => ref.read(editorPodProvider.notifier).editPlayerGroup(group),
            icon: const Icon(Icons.edit),
            tooltip: S.of(context).utils_button_edit,
          ),
        ],
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        onScanned: (p) {
          if (group != null) groupService.addPlayer(group, p);
        },
        child: group == null ? const SizedBox.shrink() : body(context, group, players),
      )),
    );
  }

  Widget body(BuildContext context, PlayerGroup group, List<Player> players) {
    final s = S.of(context);
    final error = Theme.of(context).colorScheme.error;
    final members = group.players.toList()..sort((a, b) => a.number.compareTo(b.number));
    final unknown = _unknownNumber;
    final alreadyMember = _alreadyMemberNumber;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _numberController,
                      onChanged: onNumberChanged,
                      onSubmitted: (_) => submitNumber(group, players),
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      decoration: InputDecoration(
                        labelText: s.page_playerGroup_addByNumber,
                        isDense: true,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => submitNumber(group, players),
                    child: Text(s.utils_button_add),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s.page_session_removeMode, style: removeMode ? TextStyle(color: error, fontWeight: FontWeight.bold) : null),
                  Switch(
                    value: removeMode,
                    activeThumbColor: error,
                    activeTrackColor: error.withValues(alpha: 0.4),
                    onChanged: (value) => setState(() => removeMode = value),
                  ),
                ],
              ),
              if (unknown != null) Text(s.page_session_number_unknown(unknown), style: TextStyle(color: error)),
              if (alreadyMember != null) Text(s.page_playerGroup_alreadyMember(alreadyMember), style: TextStyle(color: error)),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(s.page_playerGroup_members(members.length), style: Theme.of(context).textTheme.titleMedium),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: members.map((player) => bubble(context, group, player)).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.touch_app, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(s.page_playerGroup_help_removeMode, style: Theme.of(context).textTheme.bodySmall)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
