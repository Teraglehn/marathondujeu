import 'package:marathondujeu/src/ui/widgets/scanner_listener.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/pods/scan_status_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_player_group.dart';
import 'package:marathondujeu/src/pods/selected_session.dart';

/// Ce qu'un scan fait sur la page. Le défaut d'une page est d'ouvrir la fiche du joueur ;
/// seules la page d'un groupe et les deux pages de sessions font autre chose.
enum ScanMode {
  openPlayer,
  addToGroup,
  badgeOpenSession,
  badgeThisSession,
}

/// Écoute la douchette sur la page et pose le résultat dans `scanStatusPod` — le même retour,
/// au même endroit, sur toutes les pages. Un seul callback, stable, qui lit `widget` et les pods
/// au moment du scan : le widget survit aux rebuilds de la page, et le défilement avec lui.
class PlayerSessionScanner extends ConsumerStatefulWidget {
  final Widget child;
  final ScanMode mode;

  /// Badgeage manuel allumé (page d'une session) : badge même hors de l'horaire.
  final bool manual;

  /// Mode suppression allumé (page d'une session, d'un groupe) : le scan retire au lieu d'ajouter.
  final bool remove;

  const PlayerSessionScanner({
    super.key,
    required this.child,
    this.mode = ScanMode.openPlayer,
    this.manual = false,
    this.remove = false,
  });

  @override
  ConsumerState<PlayerSessionScanner> createState() => _PlayerSessionScannerState();
}

class _PlayerSessionScannerState extends ConsumerState<PlayerSessionScanner> {

  void scanPlayer(String qrCode) async {
    // Une frappe parasite (code vide) ne dit rien ; une boîte de dialogue ou le pas à pas de
    // l'aide, poussés sur le navigateur racine, ont leur propre écouteur ou n'attendent pas de
    // carte.
    if (qrCode.trim().isEmpty || ModalRoute.of(context)?.isCurrent == false) return;
    if (rootNavigatorKey.currentState?.canPop() == true) return;

    final result = await scan(qrCode);
    if (result != null) ref.read(scanStatusPodProvider.notifier).set(result);
  }

  Future<ScanResult?> scan(String qrCode) async {
    final service = ref.read(eventServiceProvider);
    final event = ref.read(selectedEventProvider).value;
    if (event == null) return const ScanNoEvent();

    final player = await service.getPlayerByQrCode(event, qrCode);
    if (player == null) return const ScanInvalidCard();

    switch (widget.mode) {
      case ScanMode.openPlayer:
        ref.read(editorPodProvider.notifier).editPlayer(player);
        return ScanOpened(player);
      case ScanMode.addToGroup:
        final group = ref.read(selectedPlayerGroupProvider).value;
        if (group == null) return null;
        final groupService = ref.read(playerGroupServiceProvider);
        if (widget.remove) {
          if (!group.players.contains(player)) return ScanNotInGroup(player, group);
          await groupService.removePlayer(group, player);
          return ScanRemovedFromGroup(player, group);
        }
        final added = await groupService.addPlayer(group, player);
        return added ? ScanAddedToGroup(player, group) : ScanAlreadyInGroup(player, group);
      case ScanMode.badgeOpenSession:
        return service.badgeOpenSession(event, player);
      case ScanMode.badgeThisSession:
        final session = ref.read(selectedSessionProvider).value;
        if (session == null) return null;
        if (widget.remove) return service.unbadgeSession(session, player);
        return service.badgeSession(session, player, manual: widget.manual);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScannerListener(
      onScanned: scanPlayer,
      child: widget.child,
    );
  }
}
