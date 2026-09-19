// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Players)
final playersProvider = PlayersFamily._();

final class PlayersProvider
    extends $StreamNotifierProvider<Players, List<Player>> {
  PlayersProvider._({
    required PlayersFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'playersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$playersHash();

  @override
  String toString() {
    return r'playersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Players create() => Players();

  @override
  bool operator ==(Object other) {
    return other is PlayersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playersHash() => r'1493a456242eebc8fd7452e01b83e81748adc97c';

final class PlayersFamily extends $Family
    with
        $ClassFamilyOverride<
          Players,
          AsyncValue<List<Player>>,
          List<Player>,
          Stream<List<Player>>,
          int?
        > {
  PlayersFamily._()
    : super(
        retry: null,
        name: r'playersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlayersProvider call({int? eventId}) =>
      PlayersProvider._(argument: eventId, from: this);

  @override
  String toString() => r'playersProvider';
}

abstract class _$Players extends $StreamNotifier<List<Player>> {
  late final _$args = ref.$arg as int?;
  int? get eventId => _$args;

  Stream<List<Player>> build({int? eventId});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Player>>, List<Player>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Player>>, List<Player>>,
              AsyncValue<List<Player>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(eventId: _$args));
  }
}
