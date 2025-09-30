
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_event.g.dart';

@riverpod
class SelectedEvent extends _$SelectedEvent {
  EventService get _service => ref.watch(eventServiceProvider);

  @override
  Stream<Event?> build() async* {
    final main = ref.watch(mainPodProvider);
    if(main.selectedEventId == null){
      yield null;
    }
    yield* await _service.getByIdStream(main.selectedEventId!); 
  }
}