// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_player_group.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPlayerGroup)
final selectedPlayerGroupProvider = SelectedPlayerGroupProvider._();

final class SelectedPlayerGroupProvider
    extends $StreamNotifierProvider<SelectedPlayerGroup, PlayerGroup?> {
  SelectedPlayerGroupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPlayerGroupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPlayerGroupHash();

  @$internal
  @override
  SelectedPlayerGroup create() => SelectedPlayerGroup();
}

String _$selectedPlayerGroupHash() =>
    r'02bfed1ad7c657e305e76c5426048851f9ebf382';

abstract class _$SelectedPlayerGroup extends $StreamNotifier<PlayerGroup?> {
  Stream<PlayerGroup?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PlayerGroup?>, PlayerGroup?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlayerGroup?>, PlayerGroup?>,
              AsyncValue<PlayerGroup?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
