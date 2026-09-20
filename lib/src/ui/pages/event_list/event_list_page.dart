import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
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

  // Les cibles de l'aide de la page (L12).
  final _emptyKey = GlobalKey();
  final _addKey = GlobalKey();
  final _searchKey = GlobalKey();
  final _firstKey = GlobalKey();
  final _selectorKey = GlobalKey();
  final _scanKey = GlobalKey();

  // Le pas à pas : le bloc « Créer » ou le « + » selon que la liste est vide ; la première
  // ligne quand il y en a une (les cibles absentes sont sautées).
  List<HelpStep> helpSteps() {
    final s = S.of(context);
    final empty = (ref.read(eventsProvider(criteria: criteria)).value?.isEmpty ?? true) && criteria.keyword.isEmpty;
    return [
      HelpStep(s.help_eventList_1),
      HelpStep(s.help_eventList_2, target: empty ? _emptyKey : _addKey),
      HelpStep(s.help_eventList_3, target: _searchKey),
      HelpStep(s.help_eventList_4, target: _firstKey),
      HelpStep(s.help_eventList_5, target: _selectorKey),
      HelpStep(s.help_eventList_6, target: _scanKey),
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
            key: _emptyKey,
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
          ScanStatus(key: _scanKey),
          Container(
            key: _selectorKey,
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
      body: PlayerSessionScanner(child: Column(
        children: [
          Container(
            key: _searchKey,
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
                    key: index == 0 ? _firstKey : null,
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
      )),
      floatingActionButton: FloatingActionButton(
        key: _addKey,
        onPressed: () => editor.editEvent(null),
        child: const Icon(Icons.add),
      )
    );
  }
}
