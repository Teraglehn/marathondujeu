import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/players.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerListPage extends ConsumerStatefulWidget       {
  const PlayerListPage({super.key});

  @override
  ConsumerState<PlayerListPage> createState() => _PlayerListPageState();
}

class _PlayerListPageState extends ConsumerState<PlayerListPage> {

  late SearchCriteria criteria;

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


  @override
  Widget build(BuildContext context) {
    final editor = ref.read(editorPodProvider.notifier);
    final players = ref.watch(playersProvider(criteria: criteria));
    final main = ref.watch(mainPodProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    
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
              initialValue: main.event,
              onChanged: (event) => mainNotifier.setEvent(event),
            ),
          )
        ],
      ),
      body: EventSelectedGuard(child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: SearchWidget(
              onSearchCriteriaChanged: search,
            ),
          ),
          Expanded(
            child: players.when(
              data: (data) => ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                ),
                itemBuilder: (context, index) {
                  Player player = data.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(player.name.toUpperCase().split(" ").take(2).map((s) => s.substring(0,1)).join(""))
                    ),
                    title: Text(player.name),
                    onTap: () => editor.editPlayer(player),
                  );
                },
              ), 
              error: (_, e) => Center(child: Text(e.toString())),
              loading: () => const SizedBox.shrink()
            ),
          ),
        ],
      )),
      floatingActionButton: main.event == null ? null : FloatingActionButton(
        onPressed: () => editor.editPlayer(null),
        child: const Icon(Icons.add),
      )
    );
  }
}
