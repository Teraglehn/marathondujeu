// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClockPod)
final clockPodProvider = ClockPodProvider._();

final class ClockPodProvider
    extends $StreamNotifierProvider<ClockPod, DateTime> {
  ClockPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockPodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockPodHash();

  @$internal
  @override
  ClockPod create() => ClockPod();
}

String _$clockPodHash() => r'a5de9097e923289ba44535a706ba75cafde94bde';

abstract class _$ClockPod extends $StreamNotifier<DateTime> {
  Stream<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DateTime>, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DateTime>, DateTime>,
              AsyncValue<DateTime>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
