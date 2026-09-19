// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainPod)
final mainPodProvider = MainPodProvider._();

final class MainPodProvider extends $NotifierProvider<MainPod, MainState> {
  MainPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainPodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainPodHash();

  @$internal
  @override
  MainPod create() => MainPod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MainState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MainState>(value),
    );
  }
}

String _$mainPodHash() => r'd1c1e86f346785f2591fc99cdae560ba8ad0551c';

abstract class _$MainPod extends $Notifier<MainState> {
  MainState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MainState, MainState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MainState, MainState>,
              MainState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
