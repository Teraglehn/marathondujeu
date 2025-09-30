// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsHash() => r'77205c6f4cd334d1707b06aa3c88c4f264d0a82f';

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
  late final int? eventId;

  Stream<List<Session>> build({
    int? eventId,
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
    int? eventId,
  }) {
    return SessionsProvider(
      eventId: eventId,
    );
  }

  @override
  SessionsProvider getProviderOverride(
    covariant SessionsProvider provider,
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
  String? get name => r'sessionsProvider';
}

/// See also [Sessions].
class SessionsProvider
    extends AutoDisposeStreamNotifierProviderImpl<Sessions, List<Session>> {
  /// See also [Sessions].
  SessionsProvider({
    int? eventId,
  }) : this._internal(
          () => Sessions()..eventId = eventId,
          from: sessionsProvider,
          name: r'sessionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionsHash,
          dependencies: SessionsFamily._dependencies,
          allTransitiveDependencies: SessionsFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  SessionsProvider._internal(
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
  Stream<List<Session>> runNotifierBuild(
    covariant Sessions notifier,
  ) {
    return notifier.build(
      eventId: eventId,
    );
  }

  @override
  Override overrideWith(Sessions Function() create) {
    return ProviderOverride(
      origin: this,
      override: SessionsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Sessions, List<Session>>
      createElement() {
    return _SessionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionsRef on AutoDisposeStreamNotifierProviderRef<List<Session>> {
  /// The parameter `eventId` of this provider.
  int? get eventId;
}

class _SessionsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Sessions, List<Session>>
    with SessionsRef {
  _SessionsProviderElement(super.provider);

  @override
  int? get eventId => (origin as SessionsProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
