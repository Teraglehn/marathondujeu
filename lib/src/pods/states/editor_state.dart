import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marathondujeu/src/data/data.dart';

part 'editor_state.freezed.dart';

@freezed
abstract class EditorState with _$EditorState{
  const EditorState._();

  const factory EditorState({
    Player? player,
    Event? event,
    Draw? draw,
    PlayerGroup? playerGroup,
    /// La clé du formulaire ouvert, neuve à chaque ouverture : le tiroir l'interroge avant de
    /// fermer (`DirtyAware`), et un nouvel objet recrée le formulaire.
    GlobalKey<State<StatefulWidget>>? formKey,
}) = _EditorState;

  bool get isEditing => player != null || event != null || draw != null || playerGroup != null;
}
