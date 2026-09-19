// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorState {

 Player? get player; Event? get event; Draw? get draw; PlayerGroup? get playerGroup;/// La clé du formulaire ouvert, neuve à chaque ouverture : le tiroir l'interroge avant de
/// fermer (`DirtyAware`), et un nouvel objet recrée le formulaire.
 GlobalKey<State<StatefulWidget>>? get formKey;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.player, player) || other.player == player)&&(identical(other.event, event) || other.event == event)&&(identical(other.draw, draw) || other.draw == draw)&&(identical(other.playerGroup, playerGroup) || other.playerGroup == playerGroup)&&(identical(other.formKey, formKey) || other.formKey == formKey));
}


@override
int get hashCode => Object.hash(runtimeType,player,event,draw,playerGroup,formKey);

@override
String toString() {
  return 'EditorState(player: $player, event: $event, draw: $draw, playerGroup: $playerGroup, formKey: $formKey)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 Player? player, Event? event, Draw? draw, PlayerGroup? playerGroup, GlobalKey<State<StatefulWidget>>? formKey
});




}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? player = freezed,Object? event = freezed,Object? draw = freezed,Object? playerGroup = freezed,Object? formKey = freezed,}) {
  return _then(_self.copyWith(
player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as Player?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event?,draw: freezed == draw ? _self.draw : draw // ignore: cast_nullable_to_non_nullable
as Draw?,playerGroup: freezed == playerGroup ? _self.playerGroup : playerGroup // ignore: cast_nullable_to_non_nullable
as PlayerGroup?,formKey: freezed == formKey ? _self.formKey : formKey // ignore: cast_nullable_to_non_nullable
as GlobalKey<State<StatefulWidget>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditorState value)  $default,){
final _that = this;
switch (_that) {
case _EditorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditorState value)?  $default,){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Player? player,  Event? event,  Draw? draw,  PlayerGroup? playerGroup,  GlobalKey<State<StatefulWidget>>? formKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.player,_that.event,_that.draw,_that.playerGroup,_that.formKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Player? player,  Event? event,  Draw? draw,  PlayerGroup? playerGroup,  GlobalKey<State<StatefulWidget>>? formKey)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.player,_that.event,_that.draw,_that.playerGroup,_that.formKey);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Player? player,  Event? event,  Draw? draw,  PlayerGroup? playerGroup,  GlobalKey<State<StatefulWidget>>? formKey)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.player,_that.event,_that.draw,_that.playerGroup,_that.formKey);case _:
  return null;

}
}

}

/// @nodoc


class _EditorState extends EditorState {
  const _EditorState({this.player, this.event, this.draw, this.playerGroup, this.formKey}): super._();
  

@override final  Player? player;
@override final  Event? event;
@override final  Draw? draw;
@override final  PlayerGroup? playerGroup;
/// La clé du formulaire ouvert, neuve à chaque ouverture : le tiroir l'interroge avant de
/// fermer (`DirtyAware`), et un nouvel objet recrée le formulaire.
@override final  GlobalKey<State<StatefulWidget>>? formKey;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.player, player) || other.player == player)&&(identical(other.event, event) || other.event == event)&&(identical(other.draw, draw) || other.draw == draw)&&(identical(other.playerGroup, playerGroup) || other.playerGroup == playerGroup)&&(identical(other.formKey, formKey) || other.formKey == formKey));
}


@override
int get hashCode => Object.hash(runtimeType,player,event,draw,playerGroup,formKey);

@override
String toString() {
  return 'EditorState(player: $player, event: $event, draw: $draw, playerGroup: $playerGroup, formKey: $formKey)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 Player? player, Event? event, Draw? draw, PlayerGroup? playerGroup, GlobalKey<State<StatefulWidget>>? formKey
});




}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? player = freezed,Object? event = freezed,Object? draw = freezed,Object? playerGroup = freezed,Object? formKey = freezed,}) {
  return _then(_EditorState(
player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as Player?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event?,draw: freezed == draw ? _self.draw : draw // ignore: cast_nullable_to_non_nullable
as Draw?,playerGroup: freezed == playerGroup ? _self.playerGroup : playerGroup // ignore: cast_nullable_to_non_nullable
as PlayerGroup?,formKey: freezed == formKey ? _self.formKey : formKey // ignore: cast_nullable_to_non_nullable
as GlobalKey<State<StatefulWidget>>?,
  ));
}


}

// dart format on
