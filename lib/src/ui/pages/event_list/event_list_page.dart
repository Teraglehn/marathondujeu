import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
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


  // Base vide (hors recherche) : la liste n'a rien à montrer, on guide vers la création.
  Widget emptyBlock(BuildContext context, EditorPod editor) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event, size: 96, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(S.of(context).page_eventList_empty_title, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(S.of(context).page_eventList_empty_text, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => editor.editEvent(null),
            icon: const Icon(Icons.add),
            label: Text(S.of(context).page_eventList_empty_title),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editor = ref.read(editorPodProvider.notifier);
    final events = ref.watch(eventsProvider(criteria: criteria));
    final selectedEvent = ref.watch(selectedEventProvider);
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_eventList_title),
        actions: [
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: EventSelector(
              initialValue: selectedEvent.value,
              onChanged: (event) => mainNotifier.setEventId(event?.id),
            ),
          )
        ],
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
          Expanded(
            child: events.when(
              data: (data) => data.isEmpty && criteria.keyword.isEmpty ? emptyBlock(context, editor) : ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                ),
                itemBuilder: (context, index) {
                  Event event = data.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(event.name.toUpperCase().split(" ").take(2).map((s) => s.substring(0,1)).join(""))
                    ),
                    title: Text(event.name),
                    onTap: () => editor.editEvent(event),
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
