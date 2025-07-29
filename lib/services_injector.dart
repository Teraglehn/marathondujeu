import 'package:marathondujeu/src/data/isar_client.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_injector.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

@Riverpod(keepAlive: true) IsarClient _isarClient(Ref ref) => IsarClient(isWeb: kIsWeb, isTesting: kDebugMode);

@riverpod PlayerRepository _playerRepository(Ref ref) => PlayerRepository(ref.watch(_isarClientProvider));

@riverpod PlayerService playerService(Ref ref) => PlayerService(ref.watch(_playerRepositoryProvider));


class EagerInitialization extends ConsumerWidget {
  const EagerInitialization({
    super.key, 
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_isarClientProvider);
    return child;
  }
}