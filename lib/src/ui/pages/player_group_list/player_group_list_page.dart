import 'package:go_router/go_router.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/player_groups.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/widgets/delete_player_group_dialog.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:marathondujeu/src/ui/widgets/search_widget.dart';

class PlayerGroupListPage extends ConsumerStatefulWidget       {
  const PlayerGroupListPage({super.key});

  @override
  ConsumerState<PlayerGroupListPage> createState() => _PlayerGroupListPageState();
}

class _PlayerGroupListPageState extends ConsumerState<PlayerGroupListPage> {

  late SearchCriteria criteria;

  // Les cibles de l'aide de la page (L12).
  final _addKey = GlobalKey();
  final _firstKey = GlobalKey();
  final _winnersKey = GlobalKey();
  final _scanKey = GlobalKey();

  // Le pas à pas : la première ligne quand il y en a une, sinon un pas qui dit où elles viendront.
  List<HelpStep> helpSteps() {
    final s = S.of(context);
    return [
      HelpStep(s.help_playerGroupList_1),
      HelpStep(s.help_playerGroupList_2, target: _addKey),
      if (_firstKey.currentContext == null) HelpStep(s.help_playerGroupList_3_empty),
      HelpStep(s.help_playerGroupList_3, target: _firstKey),
      HelpStep(s.help_playerGroupList_4, target: _winnersKey),
      HelpStep(s.help_playerGroupList_5, target: _scanKey),
    ];
  }

  @override
  void initState() {
    super.initState();
    criteria = const SearchCriteria();
  }

  void search(SearchCriteria criteria){
    setState(() {
      this.criteria = criteria;
    });
  }

  void goToGroup(PlayerGroup group){
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    mainNotifier.setPlayerGroupId(group.id);
    GoRouter.of(context).goNamed(Routes.playerGroup);
  }


  @override
  Widget build(BuildContext context) {

    final editor = ref.read(editorPodProvider.notifier);
    final selectedEvent = ref.watch(selectedEventProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);

    final groups = ref.watch(playerGroupsProvider(eventId: selectedEvent.value?.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_playerGroupsList_title),
        actions: [
          ScanStatus(key: _scanKey),
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: selectedEvent.value,
              onChanged: (event) => mainNotifier.setEventId(event?.id),
            ),
          ),
          HelpButton(steps: helpSteps),
        ],
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        child : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: SearchWidget(
                onSearchCriteriaChanged: search,
              ),
            ),
            Expanded(
              child: groups.when(
                // Les groupes de gagnants restent dans leur tirage (L16 Q1) : la liste ne
                // montre que les groupes faits main.
                data: (groups) => list(context, groups.where((g) => !g.isWinners).toList(), editor),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink() 
              )
            ),
            Padding(
              key: _winnersKey,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.emoji_events, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(S.of(context).page_playerGroupsList_help_winners, style: Theme.of(context).textTheme.bodySmall)),
                ],
              ),
            ),
          ],
        )
      )),
      floatingActionButton: selectedEvent.value == null ? null : FloatingActionButton(
        key: _addKey,
        onPressed: () => editor.newPlayerGroup(selectedEvent.value!),
        child: const Icon(Icons.add),
      )
    );
  }

  Widget list(BuildContext context, List<PlayerGroup> groups, EditorPod editor) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: groups.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemBuilder: (context, index) {
        final group = groups[index];
        return ListTile(
          key: index == 0 ? _firstKey : null,
          leading: CircleAvatar(
            child: Text(group.name.toUpperCase().split(" ").take(2).map((s) => s.substring(0,1)).join(""))
          ),
          title: Text(group.name),
          onTap:() => goToGroup(group),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () => editor.editPlayerGroup(group), icon: const Icon(Icons.edit), tooltip: S.of(context).utils_button_edit),
              IconButton(
                onPressed: () => deletePlayerGroup(context, ref, group),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                tooltip: S.of(context).utils_button_delete,
              ),
            ],
          ),
        );
      },
    );
  }
}
