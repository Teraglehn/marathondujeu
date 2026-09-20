import 'package:marathondujeu/src/data/isar_client.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/ui/widgets/toast.dart';
import 'dart:ui' show AppExitResponse;
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_injector.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Public : les tests de bout en bout le remplacent par une base temporaire (L18).
@Riverpod(keepAlive: true) IsarClient isarClient(Ref ref) => IsarClient(isWeb: kIsWeb, isTesting: kDebugMode);

@riverpod PlayerRepository _playerRepository(Ref ref) => PlayerRepository(ref.watch(isarClientProvider));
@riverpod PlayerGroupRepository _playerGroupRepository(Ref ref) => PlayerGroupRepository(ref.watch(isarClientProvider));
@riverpod SessionRepository _sessionRepository(Ref ref) => SessionRepository(ref.watch(isarClientProvider));
@riverpod EventRepository _eventRepository(Ref ref) => EventRepository(ref.watch(isarClientProvider));
@riverpod DrawRepository _drawRepository(Ref ref) => DrawRepository(ref.watch(isarClientProvider));
@riverpod DrawWinnerRepository _drawWinnerRepository(Ref ref) => DrawWinnerRepository(ref.watch(isarClientProvider));

@riverpod PlayerService playerService(Ref ref) => PlayerService(ref.watch(_playerRepositoryProvider));
@riverpod PlayerGroupService playerGroupService(Ref ref) => PlayerGroupService(ref.watch(_playerGroupRepositoryProvider));
@riverpod SessionService sessionService(Ref ref) => SessionService(ref.watch(_sessionRepositoryProvider));
@riverpod DrawService drawService(Ref ref) => DrawService(ref.watch(_drawRepositoryProvider), ref.watch(_drawWinnerRepositoryProvider), ref.watch(_playerGroupRepositoryProvider));
@riverpod EventService eventService(Ref ref) => EventService(ref.watch(_sessionRepositoryProvider), ref.watch(_eventRepositoryProvider), ref.watch(_playerRepositoryProvider), ref.watch(_drawWinnerRepositoryProvider));

// Le fichier de sauvegarde (L09) : un seul service, vivant tant que l'application tourne ; il
// surveille la base dès que `EagerInitialization` le crée, et signale ses échecs en toast.
@riverpod BackupFilePicker backupFilePicker(Ref ref) => const BackupFilePicker();

@Riverpod(keepAlive: true) BackupService backupService(Ref ref) {
  final service = BackupService(ref.watch(isarClientProvider));
  void toast(String Function(S s) text) {
    final context = rootNavigatorKey.currentContext;
    if (context != null && context.mounted) Toast.show(context, text(S.of(context)), error: true);
  }
  service.onError = (error) => toast((s) => s.backup_writeError(error.event.name));
  service.onPathLost = (event) => toast((s) => s.backup_pathLost(event.name));
  service.start();
  ref.onDispose(service.dispose);
  return service;
}


class EagerInitialization extends ConsumerStatefulWidget {
  const EagerInitialization({
    super.key, 
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<EagerInitialization> createState() => _EagerInitializationState();
}

class _EagerInitializationState extends ConsumerState<EagerInitialization> {
  // Fermer l'application attend l'écriture des fichiers de sauvegarde en attente (L09, C4).
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onExitRequested: () async {
      final backup = ref.read(backupServiceProvider);
      if (backup.pending) await backup.flush();
      return AppExitResponse.exit;
    });
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(isarClientProvider);
    ref.watch(backupServiceProvider);
    return widget.child;
  }
}