// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedSession)
final selectedSessionProvider = SelectedSessionProvider._();

final class SelectedSessionProvider
    extends $StreamNotifierProvider<SelectedSession, Session?> {
  SelectedSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedSessionHash();

  @$internal
  @override
  SelectedSession create() => SelectedSession();
}

String _$selectedSessionHash() => r'd7f065ace823d5beb04935c11d55c610948fc28b';

abstract class _$SelectedSession extends $StreamNotifier<Session?> {
  Stream<Session?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Session?>, Session?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Session?>, Session?>,
              AsyncValue<Session?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
