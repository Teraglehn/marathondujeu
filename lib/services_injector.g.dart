// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_injector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isarClient)
final isarClientProvider = IsarClientProvider._();

final class IsarClientProvider
    extends $FunctionalProvider<IsarClient, IsarClient, IsarClient>
    with $Provider<IsarClient> {
  IsarClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isarClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isarClientHash();

  @$internal
  @override
  $ProviderElement<IsarClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IsarClient create(Ref ref) {
    return isarClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsarClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsarClient>(value),
    );
  }
}

String _$isarClientHash() => r'7d9f70919e949aaeee5066db787ffc186f3a8589';

@ProviderFor(_playerRepository)
final _playerRepositoryProvider = _PlayerRepositoryProvider._();

final class _PlayerRepositoryProvider
    extends
        $FunctionalProvider<
          PlayerRepository,
          PlayerRepository,
          PlayerRepository
        >
    with $Provider<PlayerRepository> {
  _PlayerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_playerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_playerRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlayerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlayerRepository create(Ref ref) {
    return _playerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerRepository>(value),
    );
  }
}

String _$_playerRepositoryHash() => r'7bf335b6d27e86768b41d011dac6d6dd437b9936';

@ProviderFor(_playerGroupRepository)
final _playerGroupRepositoryProvider = _PlayerGroupRepositoryProvider._();

final class _PlayerGroupRepositoryProvider
    extends
        $FunctionalProvider<
          PlayerGroupRepository,
          PlayerGroupRepository,
          PlayerGroupRepository
        >
    with $Provider<PlayerGroupRepository> {
  _PlayerGroupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_playerGroupRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_playerGroupRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlayerGroupRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlayerGroupRepository create(Ref ref) {
    return _playerGroupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerGroupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerGroupRepository>(value),
    );
  }
}

String _$_playerGroupRepositoryHash() =>
    r'ef5f7a3da2684b0597a3e2cd909c2a734872ceef';

@ProviderFor(_sessionRepository)
final _sessionRepositoryProvider = _SessionRepositoryProvider._();

final class _SessionRepositoryProvider
    extends
        $FunctionalProvider<
          SessionRepository,
          SessionRepository,
          SessionRepository
        >
    with $Provider<SessionRepository> {
  _SessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_sessionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_sessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRepository create(Ref ref) {
    return _sessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRepository>(value),
    );
  }
}

String _$_sessionRepositoryHash() =>
    r'c8fe1cc9880488f06a40dd2cd18c113514f33978';

@ProviderFor(_eventRepository)
final _eventRepositoryProvider = _EventRepositoryProvider._();

final class _EventRepositoryProvider
    extends
        $FunctionalProvider<EventRepository, EventRepository, EventRepository>
    with $Provider<EventRepository> {
  _EventRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_eventRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_eventRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventRepository create(Ref ref) {
    return _eventRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventRepository>(value),
    );
  }
}

String _$_eventRepositoryHash() => r'4f2f09640cd8ee7c93747c3f3c67096d7b43577d';

@ProviderFor(_drawRepository)
final _drawRepositoryProvider = _DrawRepositoryProvider._();

final class _DrawRepositoryProvider
    extends $FunctionalProvider<DrawRepository, DrawRepository, DrawRepository>
    with $Provider<DrawRepository> {
  _DrawRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_drawRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_drawRepositoryHash();

  @$internal
  @override
  $ProviderElement<DrawRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DrawRepository create(Ref ref) {
    return _drawRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DrawRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DrawRepository>(value),
    );
  }
}

String _$_drawRepositoryHash() => r'62b8fc5776c4d6057f5e5bc343c4d441ea78e27c';

@ProviderFor(_drawWinnerRepository)
final _drawWinnerRepositoryProvider = _DrawWinnerRepositoryProvider._();

final class _DrawWinnerRepositoryProvider
    extends
        $FunctionalProvider<
          DrawWinnerRepository,
          DrawWinnerRepository,
          DrawWinnerRepository
        >
    with $Provider<DrawWinnerRepository> {
  _DrawWinnerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_drawWinnerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_drawWinnerRepositoryHash();

  @$internal
  @override
  $ProviderElement<DrawWinnerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DrawWinnerRepository create(Ref ref) {
    return _drawWinnerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DrawWinnerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DrawWinnerRepository>(value),
    );
  }
}

String _$_drawWinnerRepositoryHash() =>
    r'5429f89fd0e8c352b2e24fde8ab68b10b94a098d';

@ProviderFor(playerService)
final playerServiceProvider = PlayerServiceProvider._();

final class PlayerServiceProvider
    extends $FunctionalProvider<PlayerService, PlayerService, PlayerService>
    with $Provider<PlayerService> {
  PlayerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerServiceHash();

  @$internal
  @override
  $ProviderElement<PlayerService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlayerService create(Ref ref) {
    return playerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerService>(value),
    );
  }
}

String _$playerServiceHash() => r'615d2bc007d41c520979694935ea68a95230d055';

@ProviderFor(playerGroupService)
final playerGroupServiceProvider = PlayerGroupServiceProvider._();

final class PlayerGroupServiceProvider
    extends
        $FunctionalProvider<
          PlayerGroupService,
          PlayerGroupService,
          PlayerGroupService
        >
    with $Provider<PlayerGroupService> {
  PlayerGroupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerGroupServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerGroupServiceHash();

  @$internal
  @override
  $ProviderElement<PlayerGroupService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlayerGroupService create(Ref ref) {
    return playerGroupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerGroupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerGroupService>(value),
    );
  }
}

String _$playerGroupServiceHash() =>
    r'93f90bbbbb84fe681f32189f18b935198e555c3f';

@ProviderFor(sessionService)
final sessionServiceProvider = SessionServiceProvider._();

final class SessionServiceProvider
    extends $FunctionalProvider<SessionService, SessionService, SessionService>
    with $Provider<SessionService> {
  SessionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionServiceHash();

  @$internal
  @override
  $ProviderElement<SessionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionService create(Ref ref) {
    return sessionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionService>(value),
    );
  }
}

String _$sessionServiceHash() => r'183900c8d401bc89891ad78fc622ab2a5666f085';

@ProviderFor(drawService)
final drawServiceProvider = DrawServiceProvider._();

final class DrawServiceProvider
    extends $FunctionalProvider<DrawService, DrawService, DrawService>
    with $Provider<DrawService> {
  DrawServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'drawServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$drawServiceHash();

  @$internal
  @override
  $ProviderElement<DrawService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DrawService create(Ref ref) {
    return drawService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DrawService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DrawService>(value),
    );
  }
}

String _$drawServiceHash() => r'6d157a14732ac38b8e3f1450a1c8798b31ce251e';

@ProviderFor(eventService)
final eventServiceProvider = EventServiceProvider._();

final class EventServiceProvider
    extends $FunctionalProvider<EventService, EventService, EventService>
    with $Provider<EventService> {
  EventServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventServiceHash();

  @$internal
  @override
  $ProviderElement<EventService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventService create(Ref ref) {
    return eventService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventService>(value),
    );
  }
}

String _$eventServiceHash() => r'af6b8154c39473601ad11b2f1d6fa8393097ee72';
