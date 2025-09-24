import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marathondujeu/src/data/data.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState{
  const MainState._();

  const factory MainState({
    Event? event,
}) = _MainState;
}