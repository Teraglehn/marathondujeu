// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_event.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedEvent)
final selectedEventProvider = SelectedEventProvider._();

final class SelectedEventProvider
    extends $StreamNotifierProvider<SelectedEvent, Event?> {
  SelectedEventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedEventProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedEventHash();

  @$internal
  @override
  SelectedEvent create() => SelectedEvent();
}

String _$selectedEventHash() => r'e8a7c565d821e760e3c981b743bb5eae0bc1732f';

abstract class _$SelectedEvent extends $StreamNotifier<Event?> {
  Stream<Event?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Event?>, Event?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Event?>, Event?>,
              AsyncValue<Event?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
