
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_session.g.dart';

@riverpod
class SelectedSession extends _$SelectedSession {
  SessionService get _service => ref.watch(sessionServiceProvider);

  @override
  Stream<Session?> build() async* {
    final main = ref.watch(mainPodProvider);
    if(main.selectedSessionId == null){
      yield null;
    }
    yield* await _service.getByIdStream(main.selectedSessionId!); 
  }

  Future<void> save(Session item) {
    return _service.save(item);
  }

  Future<void> delete(Session item) {
    return _service.delete(item);
  }
}