
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'players.g.dart';

@riverpod
class Players extends _$Players {
  PlayerService get _service => ref.watch(playerServiceProvider);

  @override
  Stream<List<Player>> build({SearchCriteria? criteria, int? offset, int? limit}) async* {
    criteria ??= const SearchCriteria();
    yield* await _service.searchStream(criteria, offset: offset, limit: limit);
  }

  Future<void> save(Player item) {
    return _service.save(item);
  }

  Future<void> delete(Player item) {
    return _service.delete(item);
  }
}