// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditorPod)
final editorPodProvider = EditorPodProvider._();

final class EditorPodProvider
    extends $NotifierProvider<EditorPod, EditorState> {
  EditorPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editorPodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editorPodHash();

  @$internal
  @override
  EditorPod create() => EditorPod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditorState>(value),
    );
  }
}

String _$editorPodHash() => r'0380be24cd08c74c120cc8e2f370ebca0c347d08';

abstract class _$EditorPod extends $Notifier<EditorState> {
  EditorState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EditorState, EditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EditorState, EditorState>,
              EditorState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
