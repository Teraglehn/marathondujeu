// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Events)
final eventsProvider = EventsFamily._();

final class EventsProvider
    extends $StreamNotifierProvider<Events, List<Event>> {
  EventsProvider._({
    required EventsFamily super.from,
    required ({SearchCriteria? criteria, int? offset, int? limit})
    super.argument,
  }) : super(
         retry: null,
         name: r'eventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventsHash();

  @override
  String toString() {
    return r'eventsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  Events create() => Events();

  @override
  bool operator ==(Object other) {
    return other is EventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventsHash() => r'61ce1fb1556c688e467b3d9ff8f2771a0c9b5346';

final class EventsFamily extends $Family
    with
        $ClassFamilyOverride<
          Events,
          AsyncValue<List<Event>>,
          List<Event>,
          Stream<List<Event>>,
          ({SearchCriteria? criteria, int? offset, int? limit})
        > {
  EventsFamily._()
    : super(
        retry: null,
        name: r'eventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventsProvider call({SearchCriteria? criteria, int? offset, int? limit}) =>
      EventsProvider._(
        argument: (criteria: criteria, offset: offset, limit: limit),
        from: this,
      );

  @override
  String toString() => r'eventsProvider';
}

abstract class _$Events extends $StreamNotifier<List<Event>> {
  late final _$args =
      ref.$arg as ({SearchCriteria? criteria, int? offset, int? limit});
  SearchCriteria? get criteria => _$args.criteria;
  int? get offset => _$args.offset;
  int? get limit => _$args.limit;

  Stream<List<Event>> build({
    SearchCriteria? criteria,
    int? offset,
    int? limit,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Event>>, List<Event>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Event>>, List<Event>>,
              AsyncValue<List<Event>>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(
        criteria: _$args.criteria,
        offset: _$args.offset,
        limit: _$args.limit,
      ),
    );
  }
}
