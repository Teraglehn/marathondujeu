// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playersHash() => r'1493a456242eebc8fd7452e01b83e81748adc97c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Players
    extends BuildlessAutoDisposeStreamNotifier<List<Player>> {
  late final int? eventId;

  Stream<List<Player>> build({
    int? eventId,
  });
}

/// See also [Players].
@ProviderFor(Players)
const playersProvider = PlayersFamily();

/// See also [Players].
class PlayersFamily extends Family<AsyncValue<List<Player>>> {
  /// See also [Players].
  const PlayersFamily();

  /// See also [Players].
  PlayersProvider call({
    int? eventId,
  }) {
    return PlayersProvider(
      eventId: eventId,
    );
  }

  @override
  PlayersProvider getProviderOverride(
    covariant PlayersProvider provider,
  ) {
    return call(
      eventId: provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'playersProvider';
}

/// See also [Players].
class PlayersProvider
    extends AutoDisposeStreamNotifierProviderImpl<Players, List<Player>> {
  /// See also [Players].
  PlayersProvider({
    int? eventId,
  }) : this._internal(
          () => Players()..eventId = eventId,
          from: playersProvider,
          name: r'playersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playersHash,
          dependencies: PlayersFamily._dependencies,
          allTransitiveDependencies: PlayersFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  PlayersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final int? eventId;

  @override
  Stream<List<Player>> runNotifierBuild(
    covariant Players notifier,
  ) {
    return notifier.build(
      eventId: eventId,
    );
  }

  @override
  Override overrideWith(Players Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayersProvider._internal(
        () => create()..eventId = eventId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<Players, List<Player>>
      createElement() {
    return _PlayersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayersProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayersRef on AutoDisposeStreamNotifierProviderRef<List<Player>> {
  /// The parameter `eventId` of this provider.
  int? get eventId;
}

class _PlayersProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Players, List<Player>>
    with PlayersRef {
  _PlayersProviderElement(super.provider);

  @override
  int? get eventId => (origin as PlayersProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
