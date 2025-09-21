import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListPage extends ConsumerStatefulWidget       {
  const EventListPage({super.key});

  @override
  ConsumerState<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends ConsumerState<EventListPage> {

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
    final events = ref.watch(eventsProvider(criteria: criteria));
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_eventList_title),
      ),
      body: Column(
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
            child: events.when(
              data: (data) => ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                ),
                itemBuilder: (context, index) {
                  Event event = data.elementAt(index);
                  return ListTile(
                    title: Text(event.name),
                  );
                },
              ), 
              error: (_, e) => Center(child: Text(e.toString())),
              loading: () => const SizedBox.shrink()
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => editor.editEvent(null),
        child: const Icon(Icons.add),
      )
    );
  }
}
