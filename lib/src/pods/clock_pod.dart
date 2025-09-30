
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_pod.g.dart';

@riverpod
class ClockPod extends _$ClockPod {

  @override
  Stream<DateTime> build() {
    return Stream<DateTime>.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }
}