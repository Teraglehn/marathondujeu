// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draws.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Draws)
const drawsProvider = DrawsFamily._();

final class DrawsProvider extends $StreamNotifierProvider<Draws, List<Draw>> {
  const DrawsProvider._(
      {required DrawsFamily super.from, required int? super.argument})
      : super(
          retry: null,
          name: r'drawsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$drawsHash();

  @override
  String toString() {
    return r'drawsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Draws create() => Draws();

  @override
  bool operator ==(Object other) {
    return other is DrawsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$drawsHash() => r'db348d070e9853b7968bf6b860bd1149f8595b16';

final class DrawsFamily extends $Family
    with
        $ClassFamilyOverride<Draws, AsyncValue<List<Draw>>, List<Draw>,
            Stream<List<Draw>>, int?> {
  const DrawsFamily._()
      : super(
          retry: null,
          name: r'drawsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DrawsProvider call({
    int? eventId,
  }) =>
      DrawsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'drawsProvider';
}

abstract class _$Draws extends $StreamNotifier<List<Draw>> {
  late final _$args = ref.$arg as int?;
  int? get eventId => _$args;

  Stream<List<Draw>> build({
    int? eventId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      eventId: _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<List<Draw>>, List<Draw>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Draw>>, List<Draw>>,
        AsyncValue<List<Draw>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
