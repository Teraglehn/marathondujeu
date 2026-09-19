import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_session.dart';
import 'package:marathondujeu/src/services/services.dart';

typedef PlayerCallback = void Function(Player);

/// Écoute la douchette sur la page. `BarcodeKeyboardListener` garde le premier callback reçu :
/// on lui donne un seul callback, stable, qui lit `widget` et les pods au moment du scan.
/// Ainsi le widget survit aux rebuilds de la page, et le défilement avec lui.
class PlayerSessionScanner extends ConsumerStatefulWidget {
  final Widget child;

  final bool forceSelectedSession;
  final bool useSelectedSession;

  final PlayerCallback? success;
  final PlayerCallback? onScanned;

  const PlayerSessionScanner({
    super.key,
    required this.child,
    this.forceSelectedSession = false,
    this.useSelectedSession = false,
    this.onScanned,
    this.success,
  });

  @override
  ConsumerState<PlayerSessionScanner> createState() => _PlayerSessionScannerState();
}

class _PlayerSessionScannerState extends ConsumerState<PlayerSessionScanner> {

  void scanPlayer(String qrCode) async {
    final EventService service = ref.read(eventServiceProvider);
    final Event? event = ref.read(selectedEventProvider).value;
    final Session? session = ref.read(selectedSessionProvider).value;

    if(event == null) return;
    if(widget.onScanned == null){
      service.scanPlayerToSession(event, qrCode, session: widget.useSelectedSession ? session : null, force: widget.forceSelectedSession, success: widget.success);
    } else {
      final player = await service.getPlayerByQrCode(event, qrCode);
      if(player == null) return;
      widget.onScanned?.call(player);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BarcodeKeyboardListener(
      useKeyDownEvent: true,
      onBarcodeScanned: scanPlayer,
      child: widget.child
    );
  }
}
