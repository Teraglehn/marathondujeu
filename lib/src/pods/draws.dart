
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'draws.g.dart';

@riverpod
class Draws extends _$Draws {
  DrawService get _service => ref.watch(drawServiceProvider);

  @override
  Stream<List<Draw>> build({int? eventId}) async* {
    if(eventId == null){
      yield [];
    }
    yield* await _service.getByEventIdStream(eventId!);
  }

  /// Enregistre sans tirer.
  Future<void> save(Draw item) {
    return _service.save(item);
  }

  Future<void> delete(Draw item) {
    return _service.delete(item);
  }
}
