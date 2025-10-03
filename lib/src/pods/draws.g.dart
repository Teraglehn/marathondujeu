// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draws.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$drawsHash() => r'db348d070e9853b7968bf6b860bd1149f8595b16';

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

abstract class _$Draws extends BuildlessAutoDisposeStreamNotifier<List<Draw>> {
  late final int? eventId;

  Stream<List<Draw>> build({
    int? eventId,
  });
}

/// See also [Draws].
@ProviderFor(Draws)
const drawsProvider = DrawsFamily();

/// See also [Draws].
class DrawsFamily extends Family<AsyncValue<List<Draw>>> {
  /// See also [Draws].
  const DrawsFamily();

  /// See also [Draws].
  DrawsProvider call({
    int? eventId,
  }) {
    return DrawsProvider(
      eventId: eventId,
    );
  }

  @override
  DrawsProvider getProviderOverride(
    covariant DrawsProvider provider,
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
  String? get name => r'drawsProvider';
}

/// See also [Draws].
class DrawsProvider
    extends AutoDisposeStreamNotifierProviderImpl<Draws, List<Draw>> {
  /// See also [Draws].
  DrawsProvider({
    int? eventId,
  }) : this._internal(
          () => Draws()..eventId = eventId,
          from: drawsProvider,
          name: r'drawsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$drawsHash,
          dependencies: DrawsFamily._dependencies,
          allTransitiveDependencies: DrawsFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  DrawsProvider._internal(
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
  Stream<List<Draw>> runNotifierBuild(
    covariant Draws notifier,
  ) {
    return notifier.build(
      eventId: eventId,
    );
  }

  @override
  Override overrideWith(Draws Function() create) {
    return ProviderOverride(
      origin: this,
      override: DrawsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Draws, List<Draw>> createElement() {
    return _DrawsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DrawsProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DrawsRef on AutoDisposeStreamNotifierProviderRef<List<Draw>> {
  /// The parameter `eventId` of this provider.
  int? get eventId;
}

class _DrawsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Draws, List<Draw>>
    with DrawsRef {
  _DrawsProviderElement(super.provider);

  @override
  int? get eventId => (origin as DrawsProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
