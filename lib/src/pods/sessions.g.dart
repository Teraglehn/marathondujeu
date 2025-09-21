// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsHash() => r'10e965e6b2620ef3bd02124da161d71f2c1bf841';

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

abstract class _$Sessions
    extends BuildlessAutoDisposeStreamNotifier<List<Session>> {
  late final SearchCriteria? criteria;
  late final int? offset;
  late final int? limit;

  Stream<List<Session>> build({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  });
}

/// See also [Sessions].
@ProviderFor(Sessions)
const sessionsProvider = SessionsFamily();

/// See also [Sessions].
class SessionsFamily extends Family<AsyncValue<List<Session>>> {
  /// See also [Sessions].
  const SessionsFamily();

  /// See also [Sessions].
  SessionsProvider call({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) {
    return SessionsProvider(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  SessionsProvider getProviderOverride(
    covariant SessionsProvider provider,
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
  String? get name => r'sessionsProvider';
}

/// See also [Sessions].
class SessionsProvider
    extends AutoDisposeStreamNotifierProviderImpl<Sessions, List<Session>> {
  /// See also [Sessions].
  SessionsProvider({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) : this._internal(
          () => Sessions()
            ..criteria = criteria
            ..offset = offset
            ..limit = limit,
          from: sessionsProvider,
          name: r'sessionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionsHash,
          dependencies: SessionsFamily._dependencies,
          allTransitiveDependencies: SessionsFamily._allTransitiveDependencies,
          criteria: criteria,
          offset: offset,
          limit: limit,
        );

  SessionsProvider._internal(
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
  Stream<List<Session>> runNotifierBuild(
    covariant Sessions notifier,
  ) {
    return notifier.build(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  Override overrideWith(Sessions Function() create) {
    return ProviderOverride(
      origin: this,
      override: SessionsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Sessions, List<Session>>
      createElement() {
    return _SessionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsProvider &&
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
mixin SessionsRef on AutoDisposeStreamNotifierProviderRef<List<Session>> {
  /// The parameter `criteria` of this provider.
  SearchCriteria? get criteria;

  /// The parameter `offset` of this provider.
  int? get offset;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _SessionsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Sessions, List<Session>>
    with SessionsRef {
  _SessionsProviderElement(super.provider);

  @override
  SearchCriteria? get criteria => (origin as SessionsProvider).criteria;
  @override
  int? get offset => (origin as SessionsProvider).offset;
  @override
  int? get limit => (origin as SessionsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
