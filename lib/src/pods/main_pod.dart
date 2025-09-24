
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/states/main_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_pod.g.dart';

@Riverpod(keepAlive: true)
class MainPod extends _$MainPod {
  @override
  MainState build() {
    return const MainState();
  }

  void setEvent(Event? event) {
    event ??= Event.empty();

    state = MainState(event: event);
  }
}