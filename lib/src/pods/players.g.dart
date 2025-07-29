// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playersHash() => r'f70aa5837860782d33f3a16a8c68a0707177d5d9';

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
  late final SearchCriteria? criteria;
  late final int? offset;
  late final int? limit;

  Stream<List<Player>> build({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
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
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) {
    return PlayersProvider(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  PlayersProvider getProviderOverride(
    covariant PlayersProvider provider,
  ) {
    return call(
      criteria: provider.criteria,
      offset: provider.offset,
      limit: provider.limit,
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
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) : this._internal(
          () => Players()
            ..criteria = criteria
            ..offset = offset
            ..limit = limit,
          from: playersProvider,
          name: r'playersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playersHash,
          dependencies: PlayersFamily._dependencies,
          allTransitiveDependencies: PlayersFamily._allTransitiveDependencies,
          criteria: criteria,
          offset: offset,
          limit: limit,
        );

  PlayersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.criteria,
    required this.offset,
    required this.limit,
  }) : super.internal();

  final SearchCriteria? criteria;
  final int? offset;
  final int? limit;

  @override
  Stream<List<Player>> runNotifierBuild(
    covariant Players notifier,
  ) {
    return notifier.build(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  Override overrideWith(Players Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayersProvider._internal(
        () => create()
          ..criteria = criteria
          ..offset = offset
          ..limit = limit,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        criteria: criteria,
        offset: offset,
        limit: limit,
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
    return other is PlayersProvider &&
        other.criteria == criteria &&
        other.offset == offset &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, criteria.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlayersRef on AutoDisposeStreamNotifierProviderRef<List<Player>> {
  /// The parameter `criteria` of this provider.
  SearchCriteria? get criteria;

  /// The parameter `offset` of this provider.
  int? get offset;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _PlayersProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Players, List<Player>>
    with PlayersRef {
  _PlayersProviderElement(super.provider);

  @override
  SearchCriteria? get criteria => (origin as PlayersProvider).criteria;
  @override
  int? get offset => (origin as PlayersProvider).offset;
  @override
  int? get limit => (origin as PlayersProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
