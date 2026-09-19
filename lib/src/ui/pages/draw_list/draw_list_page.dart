import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/draws.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawListPage extends ConsumerStatefulWidget       {
  const DrawListPage({super.key});

  @override
  ConsumerState<DrawListPage> createState() => _DrawListPageState();
}

class _DrawListPageState extends ConsumerState<DrawListPage> {

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

  void deleteDraw(Draw draw) {
    ref.read(drawsProvider().notifier)
      .delete(draw);
  }


  @override
  Widget build(BuildContext context) {
    final editor = ref.read(editorPodProvider.notifier);
    final selectedEvent = ref.watch(selectedEventProvider);
    final draws = ref.watch(drawsProvider(eventId: selectedEvent.value?.id));
    final mainNotifier = ref.watch(mainPodProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).page_drawList_title),
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
      body: EventSelectedGuard(builder: (selectedEvent) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: SearchWidget(
              onSearchCriteriaChanged: search,
            ),
          ),
          Expanded(
            child: draws.when(
              data: (data) => ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1.0,
                ),
                itemBuilder: (context, index) {
                  Draw draw = data.elementAt(index);
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text((index+1).toString())
                        ),
                        title: Text(draw.name),
                        subtitle: Wrap(spacing: 8, runSpacing: 8, children: 
                          (draw.winners.toList()..sort((a, b) => a.position.compareTo(b.position))).map((w) => Card(
                            clipBehavior: Clip.hardEdge,
                            elevation: 8,
                            child: InkWell(
                              onTap: () => editor.editPlayer(w.winner.value!),
                              child: Padding(
                                padding: const EdgeInsetsGeometry.all(8),
                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text("N°${w.position.toString()}"),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                    child: Text(w.winner.value!.qrcode)
                                  )
                                ])
                              ),
                            )
                          )).toList()
                        ),
                        trailing: IconButton(onPressed: () => deleteDraw(draw), icon: Icon(Icons.delete), color: Theme.of(context).colorScheme.error),
                      ),
                      
                    ],
                  );
                },
              ), 
              error: (_, e) => Center(child: Text(e.toString())),
              loading: () => const SizedBox.shrink()
            ),
          ),
        ],
      )),
      floatingActionButton: selectedEvent.value == null ? null : FloatingActionButton(
        onPressed: () => editor.newDraw(selectedEvent.value!),
        child: const Icon(Icons.add),
      )
    );
  }
}