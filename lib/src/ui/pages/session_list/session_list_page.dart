import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/sessions.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionListPage extends ConsumerStatefulWidget       {
  const SessionListPage({super.key});

  @override
  ConsumerState<SessionListPage> createState() => _SessionListPageState();
}

class _SessionListPageState extends ConsumerState<SessionListPage> {

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
    final sessions = ref.watch(sessionsProvider(criteria: criteria));
    final main = ref.watch(mainPodProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_sessionList_title),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.inversePrimary,
              leading: const CircleAvatar(
                child: Icon(Icons.add)
              ),
              title: const Text("Start a session"),
              onTap: () => "",
            ),
          ),
          const Divider(),
          Expanded(
            child: sessions.when(
              data: (data) => ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                ),
                itemBuilder: (context, index) {
                  Session session = data.elementAt(index);
                  return ListTile(
                    title: Text("${session.startTime.toIso8601String()} ${session.endTime?.toIso8601String() ?? ""}"),
                  );
                },
              ), 
              error: (_, e) => Center(child: Text(e.toString())),
              loading: () => const SizedBox.shrink()
            ),
          ),
        ],
      )),
    );
  }
}
