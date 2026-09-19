// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_groups.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlayerGroups)
const playerGroupsProvider = PlayerGroupsFamily._();

final class PlayerGroupsProvider
    extends $StreamNotifierProvider<PlayerGroups, List<PlayerGroup>> {
  const PlayerGroupsProvider._(
      {required PlayerGroupsFamily super.from, required int? super.argument})
      : super(
          retry: null,
          name: r'playerGroupsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$playerGroupsHash();

  @override
  String toString() {
    return r'playerGroupsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PlayerGroups create() => PlayerGroups();

  @override
  bool operator ==(Object other) {
    return other is PlayerGroupsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playerGroupsHash() => r'aabae8e6adce7e7ee0ffdf708f8c718033af283c';

final class PlayerGroupsFamily extends $Family
    with
        $ClassFamilyOverride<PlayerGroups, AsyncValue<List<PlayerGroup>>,
            List<PlayerGroup>, Stream<List<PlayerGroup>>, int?> {
  const PlayerGroupsFamily._()
      : super(
          retry: null,
          name: r'playerGroupsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PlayerGroupsProvider call({
    int? eventId,
  }) =>
      PlayerGroupsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'playerGroupsProvider';
}

abstract class _$PlayerGroups extends $StreamNotifier<List<PlayerGroup>> {
  late final _$args = ref.$arg as int?;
  int? get eventId => _$args;

  Stream<List<PlayerGroup>> build({
    int? eventId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      eventId: _$args,
    );
    final ref =
        this.ref as $Ref<AsyncValue<List<PlayerGroup>>, List<PlayerGroup>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PlayerGroup>>, List<PlayerGroup>>,
        AsyncValue<List<PlayerGroup>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
