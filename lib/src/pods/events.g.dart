// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventsHash() => r'3fdca6bacab2a34c09aa342c2ac61c7cacd622cf';

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

abstract class _$Events
    extends BuildlessAutoDisposeStreamNotifier<List<Event>> {
  late final SearchCriteria? criteria;
  late final int? offset;
  late final int? limit;

  Stream<List<Event>> build({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  });
}

/// See also [Events].
@ProviderFor(Events)
const eventsProvider = EventsFamily();

/// See also [Events].
class EventsFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [Events].
  const EventsFamily();

  /// See also [Events].
  EventsProvider call({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) {
    return EventsProvider(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  EventsProvider getProviderOverride(
    covariant EventsProvider provider,
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
  String? get name => r'eventsProvider';
}

/// See also [Events].
class EventsProvider
    extends AutoDisposeStreamNotifierProviderImpl<Events, List<Event>> {
  /// See also [Events].
  EventsProvider({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  }) : this._internal(
          () => Events()
            ..criteria = criteria
            ..offset = offset
            ..limit = limit,
          from: eventsProvider,
          name: r'eventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$eventsHash,
          dependencies: EventsFamily._dependencies,
          allTransitiveDependencies: EventsFamily._allTransitiveDependencies,
          criteria: criteria,
          offset: offset,
          limit: limit,
        );

  EventsProvider._internal(
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
  Stream<List<Event>> runNotifierBuild(
    covariant Events notifier,
  ) {
    return notifier.build(
      criteria: criteria,
      offset: offset,
      limit: limit,
    );
  }

  @override
  Override overrideWith(Events Function() create) {
    return ProviderOverride(
      origin: this,
      override: EventsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Events, List<Event>>
      createElement() {
    return _EventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsProvider &&
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
mixin EventsRef on AutoDisposeStreamNotifierProviderRef<List<Event>> {
  /// The parameter `criteria` of this provider.
  SearchCriteria? get criteria;

  /// The parameter `offset` of this provider.
  int? get offset;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _EventsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Events, List<Event>>
    with EventsRef {
  _EventsProviderElement(super.provider);

  @override
  SearchCriteria? get criteria => (origin as EventsProvider).criteria;
  @override
  int? get offset => (origin as EventsProvider).offset;
  @override
  int? get limit => (origin as EventsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
