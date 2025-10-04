
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_groups.g.dart';

@riverpod
class PlayerGroups extends _$PlayerGroups {
  PlayerGroupService get _service => ref.watch(playerGroupServiceProvider);

  @override
  Stream<List<PlayerGroup>> build({int? eventId}) async* {
    if(eventId == null){
      yield [];
    }
    yield* await _service.getByEventIdStream(eventId!);
  }

  Future<void> save(PlayerGroup item) {
    return _service.save(item);
  }

  Future<void> delete(PlayerGroup item) {
    return _service.delete(item);
  }
}