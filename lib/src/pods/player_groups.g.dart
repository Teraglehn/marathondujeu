// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_groups.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerGroupsHash() => r'aabae8e6adce7e7ee0ffdf708f8c718033af283c';

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

abstract class _$PlayerGroups
    extends BuildlessAutoDisposeStreamNotifier<List<PlayerGroup>> {
  late final int? eventId;

  Stream<List<PlayerGroup>> build({
    int? eventId,
  });
}

/// See also [PlayerGroups].
@ProviderFor(PlayerGroups)
const playerGroupsProvider = PlayerGroupsFamily();

/// See also [PlayerGroups].
class PlayerGroupsFamily extends Family<AsyncValue<List<PlayerGroup>>> {
  /// See also [PlayerGroups].
  const PlayerGroupsFamily();

  /// See also [PlayerGroups].
  PlayerGroupsProvider call({
    int? eventId,
  }) {
    return PlayerGroupsProvider(
      eventId: eventId,
    );
  }

  @override
  PlayerGroupsProvider getProviderOverride(
    covariant PlayerGroupsProvider provider,
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
  String? get name => r'playerGroupsProvider';
}

/// See also [PlayerGroups].
class PlayerGroupsProvider extends AutoDisposeStreamNotifierProviderImpl<
    PlayerGroups, List<PlayerGroup>> {
  /// See also [PlayerGroups].
  PlayerGroupsProvider({
    int? eventId,
  }) : this._internal(
          () => PlayerGroups()..eventId = eventId,
          from: playerGroupsProvider,
          name: r'playerGroupsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playerGroupsHash,
          dependencies: PlayerGroupsFamily._dependencies,
          allTransitiveDependencies:
              PlayerGroupsFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  PlayerGroupsProvider._internal(
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
  Stream<List<PlayerGroup>> runNotifierBuild(
    covariant PlayerGroups notifier,
  ) {
    return notifier.build(
      eventId: eventId,
    );
  }

  @override
  Override overrideWith(PlayerGroups Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayerGroupsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<PlayerGroups, List<PlayerGroup>>
      createElement() {
    return _PlayerGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerGroupsProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayerGroupsRef
    on AutoDisposeStreamNotifierProviderRef<List<PlayerGroup>> {
  /// The parameter `eventId` of this provider.
  int? get eventId;
}

class _PlayerGroupsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PlayerGroups,
        List<PlayerGroup>> with PlayerGroupsRef {
  _PlayerGroupsProviderElement(super.provider);

  @override
  int? get eventId => (origin as PlayerGroupsProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
