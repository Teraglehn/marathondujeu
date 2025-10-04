import 'package:marathondujeu/src/pods/states/main_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_pod.g.dart';

@Riverpod(keepAlive: true)
class MainPod extends _$MainPod {
  @override
  MainState build() {
    return const MainState();
  }

  void setEventId(int? eventId) {
    state = state.copyWith(selectedEventId: eventId);
  }

  void setSessionId(int? sessionId) {
    state = state.copyWith(selectedSessionId: sessionId);
  }

  void setPlayerGroupId(int? playerGroupId) {
    state = state.copyWith(selectedPlayerGroupId: playerGroupId);
  }
}