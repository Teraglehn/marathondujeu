import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/pods/selected_session.dart';
import 'package:marathondujeu/src/services/services.dart';

typedef PlayerCallback = void Function(Player);

class PlayerSessionScanner extends ConsumerWidget {
  final Widget child;

  final bool forceSelectedSession;
  final bool useSelectedSession;

  final PlayerCallback? success;

  const PlayerSessionScanner({
    super.key, 
    required this.child,
    required this.forceSelectedSession,
    this.useSelectedSession = false,
    this.success,
  });

  void scanPlayer(EventService service, Event? event, Session? session, String qrCode){
    if(event == null) return;
    service.scanPlayerToSession(event, qrCode, session: useSelectedSession ? session : null, force: forceSelectedSession, success: success);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final selectedSession = ref.watch(selectedSessionProvider);
    final eventService = ref.watch(eventServiceProvider);

    return BarcodeKeyboardListener(
      key: UniqueKey(),
      useKeyDownEvent: true,
      onBarcodeScanned: (qrCode) => scanPlayer(eventService, selectedEvent.value, selectedSession.value, qrCode),
      child: child
    );
  }
}