import 'package:go_router/go_router.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/pods/selected_player_group.dart';
import 'package:marathondujeu/src/ui/pages/utils/event_selected_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';

class PlayerGroupPage extends ConsumerStatefulWidget {

  const PlayerGroupPage({super.key});

  @override
  ConsumerState<PlayerGroupPage> createState() => _PlayerGroupPageState();
}

class _PlayerGroupPageState extends ConsumerState<PlayerGroupPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedGroup = ref.watch(selectedPlayerGroupProvider);
    final groupService = ref.watch(playerGroupServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).goNamed(Routes.playerGroupList), 
          icon: const Icon(Icons.arrow_back)
        ),
        title: Text("${S.of(context).page_playerGroup_title} : ${selectedGroup.value?.name}"),
      ),
      body: EventSelectedGuard(builder: (selectedEvent) => PlayerSessionScanner(
        onScanned: (p) {
          selectedGroup.value!.players.add(p);
          groupService.save(selectedGroup.value!);
        },
        child : Column(
          children: [
            Expanded(
              child: selectedGroup.when(
                data: (selectedGroup) => GridView.extent(
                  padding: const EdgeInsets.all(8),
                  maxCrossAxisExtent: 50.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: selectedGroup!.players.map((player) => CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        child: Text(player.qrcode)
                    )
                  ).toList()
                ),
                error: (_, e) => Center(child: Text(e.toString())),
                loading: () => const SizedBox.shrink() 
              )
            ),
          ],
        ))
      ),
    );
  }
}
