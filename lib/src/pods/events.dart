
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events.g.dart';

@riverpod
class Events extends _$Events {
  EventService get _service => ref.watch(eventServiceProvider);

  @override
  Stream<List<Event>> build({SearchCriteria? criteria, int? offset, int? limit}) async* {
    criteria ??= const SearchCriteria();
    yield* await _service.searchStream(criteria, offset: offset, limit: limit);
  }

  Future<void> save(Event item, {bool regenerateSessions = false}) {
    return _service.save(item, regenerateSessions: regenerateSessions);
  }

  /// Ferme l'événement : lui et toutes ses données (L21).
  Future<void> destroy(Event item) {
    return _service.destroyEvent(item);
  }
}