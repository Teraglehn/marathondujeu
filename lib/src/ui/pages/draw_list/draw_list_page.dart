import 'package:intl/intl.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/draws.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:marathondujeu/src/ui/widgets/winner_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawListPage extends ConsumerStatefulWidget       {
  const DrawListPage({super.key});

  @override
  ConsumerState<DrawListPage> createState() => _DrawListPageState();
}

class _DrawListPageState extends ConsumerState<DrawListPage> {

  // Les cibles de l'aide de la page (L12) : la première ligne, le premier tirage effectué
  // (cadenas) et son bouton *Copier*.
  final _addKey = GlobalKey();
  final _firstKey = GlobalKey();
  final _drawnKey = GlobalKey();
  final _copyKey = GlobalKey();
  final _scanKey = GlobalKey();

  List<HelpStep> helpSteps() {
    final s = S.of(context);
    return [
      HelpStep(s.help_drawList_1),
      HelpStep(s.help_drawList_2, target: _addKey),
      if (_firstKey.currentContext == null && _drawnKey.currentContext == null) HelpStep(s.help_drawList_3_empty),
      HelpStep(s.help_drawList_3, target: _firstKey),
      HelpStep(s.help_drawList_3_drawn, target: _drawnKey),
      HelpStep(s.help_drawList_4, target: _copyKey),
      HelpStep(s.help_drawList_5, target: _scanKey),
    ];
  }

  /// Ouvre l'éditeur sur une copie, non enregistrée.
  Future<void> copyDraw(Draw draw) async {
    final copy = await ref.read(drawServiceProvider).createDrawFromDraw(draw);
    ref.read(editorPodProvider.notifier).editDraw(copy);
  }

  /// « Tiré le … » pour un tirage effectué ; rien pour un tirage préparé.
  Widget? drawnLabel(BuildContext context, Draw draw) {
    if (!draw.isDrawn) return null;
    final text = draw.drawnAt != null
      ? S.of(context).data_draw_drawnAt(DateFormat.yMd(S.of(context).localeName).add_Hm().format(draw.drawnAt!))
      : S.of(context).data_draw_drawn;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.lock, size: 16),
      const SizedBox(width: 4),
      Text(text, style: Theme.of(context).textTheme.bodySmall),
    ]);
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
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(child: Column(
        children: [
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
                  final firstDrawn = draw.isDrawn && draw == data.firstWhere((d) => d.isDrawn);
                  return Column(
                    children: [
                      ListTile(
                        key: firstDrawn ? _drawnKey : index == 0 ? _firstKey : null,
                        onTap: () => editor.editDraw(draw),
                        leading: CircleAvatar(
                          child: Text(draw.number.toString())
                        ),
                        title: Row(children: [
                          Text(draw.name),
                          if (draw.isDrawn) ...[const SizedBox(width: 12), drawnLabel(context, draw)!],
                        ]),
                        subtitle: Wrap(spacing: 8, runSpacing: 8, children: 
                          (draw.winners.toList()..sort((a, b) => a.position.compareTo(b.position))).map((w) => WinnerCard(
                            position: w.position,
                            number: w.winner.value!.number,
                            onTap: () => editor.editPlayer(w.winner.value!),
                          )).toList()
                        ),
                        trailing: IconButton(key: index == 0 ? _copyKey : null, onPressed: () => copyDraw(draw), icon: const Icon(Icons.copy), tooltip: S.of(context).data_draw_copy_help),
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
      ))),
      floatingActionButton: selectedEvent.value == null ? null : FloatingActionButton(
        key: _addKey,
        onPressed: () async => editor.editDraw(await ref.read(drawServiceProvider).createDraw(selectedEvent.value!)),
        child: const Icon(Icons.add),
      )
    );
  }
}