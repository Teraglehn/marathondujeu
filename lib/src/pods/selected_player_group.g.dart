// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_player_group.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPlayerGroup)
const selectedPlayerGroupProvider = SelectedPlayerGroupProvider._();

final class SelectedPlayerGroupProvider
    extends $StreamNotifierProvider<SelectedPlayerGroup, PlayerGroup?> {
  const SelectedPlayerGroupProvider._()
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
    r'af0774e11a10632fd410d7127c831be5ed9725b8';

abstract class _$SelectedPlayerGroup extends $StreamNotifier<PlayerGroup?> {
  Stream<PlayerGroup?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PlayerGroup?>, PlayerGroup?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PlayerGroup?>, PlayerGroup?>,
        AsyncValue<PlayerGroup?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
