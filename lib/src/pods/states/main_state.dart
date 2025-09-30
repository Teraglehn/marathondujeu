import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState{
  const MainState._();

  const factory MainState({
    int? selectedEventId,
    int? selectedSessionId,
}) = _MainState;
}