
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sessions.g.dart';

@riverpod
class Sessions extends _$Sessions {
  SessionService get _service => ref.watch(sessionServiceProvider);

  @override
  Stream<List<Session>> build({SearchCriteria? criteria, int? offset, int? limit}) async* {
    criteria ??= const SearchCriteria();
    yield* await _service.searchStream(criteria, offset: offset, limit: limit);
  }

  Future<void> save(Session item) {
    return _service.save(item);
  }

  Future<void> delete(Session item) {
    return _service.delete(item);
  }
}