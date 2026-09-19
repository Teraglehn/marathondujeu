// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Sessions)
const sessionsProvider = SessionsFamily._();

final class SessionsProvider
    extends $StreamNotifierProvider<Sessions, List<Session>> {
  const SessionsProvider._(
      {required SessionsFamily super.from, required int? super.argument})
      : super(
          retry: null,
          name: r'sessionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sessionsHash();

  @override
  String toString() {
    return r'sessionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Sessions create() => Sessions();

  @override
  bool operator ==(Object other) {
    return other is SessionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionsHash() => r'77205c6f4cd334d1707b06aa3c88c4f264d0a82f';

final class SessionsFamily extends $Family
    with
        $ClassFamilyOverride<Sessions, AsyncValue<List<Session>>, List<Session>,
            Stream<List<Session>>, int?> {
  const SessionsFamily._()
      : super(
          retry: null,
          name: r'sessionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SessionsProvider call({
    int? eventId,
  }) =>
      SessionsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'sessionsProvider';
}

abstract class _$Sessions extends $StreamNotifier<List<Session>> {
  late final _$args = ref.$arg as int?;
  int? get eventId => _$args;

  Stream<List<Session>> build({
    int? eventId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      eventId: _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<List<Session>>, List<Session>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Session>>, List<Session>>,
        AsyncValue<List<Session>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
