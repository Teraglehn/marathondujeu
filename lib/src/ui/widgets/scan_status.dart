import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/scan_status_pod.dart';
import 'package:marathondujeu/src/ui/pages/utils/player_session_scanner.dart';

/// Le texte d'un résultat — le même dans la barre (scan) et en toast (champ *Numéro*).
String scanResultText(S s, ScanResult result) => switch (result) {
  ScanOpened(:final player) => s.scan_opened(player.number),
  ScanAddedToGroup(:final player) => s.scan_addedToGroup(player.number),
  ScanAlreadyInGroup(:final player) => s.scan_alreadyInGroup(player.number),
  ScanRemovedFromGroup(:final player) => s.scan_removedFromGroup(player.number),
  ScanNotInGroup(:final player) => s.scan_notInGroup(player.number),
  ScanBadged(:final player, :final session) => s.scan_badged(player.number, session.number),
  ScanAlreadyPresent(:final player, :final session) => s.scan_alreadyPresent(player.number, session.number),
  ScanRemovedFromSession(:final player, :final session) => s.scan_removedFromSession(player.number, session.number),
  ScanNotPresent(:final player, :final session) => s.scan_notPresent(player.number, session.number),
  ScanNoOpenSession() => s.scan_noOpenSession,
  ScanSessionNotOpen() => s.scan_sessionNotOpen,
  ScanInvalidCard() => s.scan_invalidCard,
  ScanNoEvent() => s.scan_noEvent,
};

/// Le retour de scan, dans la barre du haut de chaque page : une douchette et le dernier
/// message — vert pour un succès, rouge pour une erreur. Tant que rien n'a été scanné, il dit
/// ce qu'un scan fait sur cette page ([mode]). En mode suppression ([remove]), il prend un fond
/// « erreur » et clignote au passage, pour qu'on voie que le scan retire.
class ScanStatus extends ConsumerStatefulWidget {
  final ScanMode mode;
  final bool remove;

  const ScanStatus({super.key, this.mode = ScanMode.openPlayer, this.remove = false});

  @override
  ConsumerState<ScanStatus> createState() => _ScanStatusState();
}

class _ScanStatusState extends ConsumerState<ScanStatus> with SingleTickerProviderStateMixin {
  static const _blink = Duration(milliseconds: 250);
  static const _blinkFor = Duration(milliseconds: 1500);

  late final AnimationController _controller = AnimationController(vsync: this, duration: _blink, value: 1);
  Timer? _blinkTimer;

  @override
  void didUpdateWidget(ScanStatus oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.remove == oldWidget.remove) return;
    // Ce qu'un scan fait vient de changer : le dernier résultat ne vaut plus, place au message.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(scanStatusPodProvider.notifier).clear();
    });
    if (widget.remove) blink();
  }

  void blink() {
    _controller.repeat(reverse: true);
    _blinkTimer?.cancel();
    _blinkTimer = Timer(_blinkFor, () {
      _controller.stop();
      _controller.animateTo(1);
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  String idle(S s) => switch ((widget.mode, widget.remove)) {
    (ScanMode.openPlayer, _) => s.scan_hint_openPlayer,
    (ScanMode.addToGroup, false) => s.scan_hint_addToGroup,
    (ScanMode.addToGroup, true) => s.scan_hint_removeFromGroup,
    (ScanMode.badgeOpenSession, _) => s.scan_hint_badgeOpenSession,
    (ScanMode.badgeThisSession, false) => s.scan_hint_badgeThisSession,
    (ScanMode.badgeThisSession, true) => s.scan_hint_removeFromSession,
  };

  String text(S s, ScanResult? result) => result == null ? idle(s) : scanResultText(s, result);

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(scanStatusPodProvider);
    final scheme = Theme.of(context).colorScheme;
    final Color color;
    if (widget.remove) {
      color = scheme.onErrorContainer;
    } else if (result == null) {
      color = scheme.onPrimary;
    } else {
      color = result.isError ? scheme.error : Colors.green.shade700;
    }
    return FadeTransition(
      opacity: _controller,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        constraints: const BoxConstraints(maxWidth: 640),
        decoration: widget.remove
          ? BoxDecoration(color: scheme.errorContainer, borderRadius: BorderRadius.circular(8))
          : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text(S.of(context), result),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
