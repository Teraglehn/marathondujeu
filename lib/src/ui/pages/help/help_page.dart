import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';
import 'package:marathondujeu/src/ui/widgets/player_bubble.dart';
import 'package:marathondujeu/src/ui/widgets/player_list_card.dart';
import 'package:marathondujeu/src/ui/widgets/scan_status.dart';
import 'package:marathondujeu/src/ui/widgets/session_card.dart';
import 'package:marathondujeu/src/ui/widgets/winner_card.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// Le guide (L12b) : le parcours d'une édition en six temps, chacun illustré par les vrais
/// composants de l'écran avec des données d'exemple, et un bouton vers la page où il se joue.
/// En tête, où trouver l'aide dans chaque page. Toujours accessible, événement ou pas.
class HelpPage extends ConsumerWidget {
  const HelpPage({super.key});

  static const double _maxWidth = 900;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final theme = Theme.of(context);
    // Sans événement en base, seule la page des événements s'ouvre — la même règle que le rail.
    final noEvent = ref.watch(eventsProvider()).value?.isEmpty ?? false;
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(s.help_guide_title),
        actions: const [ScanStatus()],
      ),
      body: PlayerSessionScanner(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.help_guide_intro, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  Text(s.help_guide_where_title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _whereRow(context, HelpHint(s.help_guide_where_hint), s.help_guide_where_hint),
                  _whereRow(context, const Icon(Icons.info_outline, size: 16), s.help_guide_where_legend),
                  _whereRow(context, const Icon(Icons.info_outline), s.help_guide_where_tour),
                  const SizedBox(height: 16),
                  _step(context, 1, s.help_guide_step_1_title, s.help_guide_step_1_text, Routes.eventList, s.page_eventList_menuItem, false,
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      _sampleTile(context, s.help_guide_sample_event),
                      const SizedBox(height: 8),
                      _sampleBackup(context, s.backup_suggestedName(s.help_guide_sample_event), s.backup_lastWritten('14:32:05')),
                    ])),
                  _step(context, 2, s.help_guide_step_2_title, s.help_guide_step_2_text, Routes.playerList, s.page_playerList_menuItem, noEvent,
                    const PlayerListCard(number: 12, name: '12', sessions: 2, bonus: 1, tokens: 3)),
                  _step(context, 3, s.help_guide_step_3_title, s.help_guide_step_3_text, Routes.cardGenerator, s.page_cardGenerator_menuItem, noEvent,
                    _sampleCard(context)),
                  _step(context, 4, s.help_guide_step_4_title, s.help_guide_step_4_text, Routes.sessionList, s.page_sessionList_menuItem, noEvent,
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      SessionCard(session: _sampleSession(now), presentCount: 2, now: now),
                      const SizedBox(width: 16),
                      _bubble(context, 12),
                      const SizedBox(width: 8),
                      _bubble(context, 7),
                    ])),
                  _step(context, 5, s.help_guide_step_5_title, s.help_guide_step_5_text, Routes.playerGroupList, s.page_playerGroupsList_menuItem, noEvent,
                    _sampleTile(context, s.help_guide_sample_group)),
                  _step(context, 6, s.help_guide_step_6_title, s.help_guide_step_6_text, Routes.drawList, s.page_drawList_menuItem, noEvent,
                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.lock, size: 16),
                        const SizedBox(width: 4),
                        Text(s.data_draw_drawn, style: theme.textTheme.bodySmall),
                      ]),
                      Row(mainAxisSize: MainAxisSize.min, children: const [
                        WinnerCard(position: 1, number: 12),
                        SizedBox(width: 8),
                        WinnerCard(position: 2, number: 7),
                      ]),
                    ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _whereRow(BuildContext context, Widget icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 32, child: Center(child: icon)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }

  // Un temps du parcours : son numéro, son titre, deux phrases, le bouton vers sa page ;
  // l'illustration à droite.
  Widget _step(BuildContext context, int number, String title, String text, String route, String pageLabel, bool disabled, Widget illustration) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            child: Text(number.toString()),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(text, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: disabled ? null : () => GoRouter.of(context).goNamed(route),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(S.of(context).help_guide_open(pageLabel)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          illustration,
        ],
      ),
    );
  }

  // Une ligne de liste (événement, groupe) : les initiales et le nom.
  Widget _sampleTile(BuildContext context, String name) {
    return SizedBox(
      width: 280,
      child: ListTile(
        leading: CircleAvatar(child: Text(name.toUpperCase().split(" ").take(2).map((s) => s.substring(0, 1)).join(""))),
        title: Text(name),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
    );
  }

  // Le fichier de sauvegarde tel que l'éditeur le montre : son nom, l'heure de la dernière écriture.
  Widget _sampleBackup(BuildContext context, String name, String written) {
    final theme = Theme.of(context);
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(children: [
        const Icon(Icons.save_outlined),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: theme.textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
          Text(written, style: theme.textTheme.bodySmall),
        ])),
      ]),
    );
  }

  // Une carte de joueur telle qu'imprimée : le code et le numéro.
  Widget _sampleCard(BuildContext context) {
    return Container(
      width: 150,
      height: 95,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: PrettyQrView(
              qrImage: const PlayerCard(code: '12').getQrImage(),
              decoration: const PrettyQrDecoration(shape: PrettyQrSmoothSymbol(roundFactor: 0)),
            ),
          ),
          Expanded(child: Center(child: Text('12', style: Theme.of(context).textTheme.headlineMedium))),
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context, int number) => PlayerBubble(
    number: number,
    color: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
  );

  // La session d'exemple, ouverte : jamais enregistrée, construite en mémoire.
  static Session _sampleSession(DateTime now) {
    final session = Session()
      ..number = 3
      ..startTime = now.subtract(const Duration(minutes: 5))
      ..endTime = now.add(const Duration(minutes: 10));
    return session;
  }
}
