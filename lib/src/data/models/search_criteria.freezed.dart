// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchCriteria {

 String get keyword; Event? get event;
/// Create a copy of SearchCriteria
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchCriteriaCopyWith<SearchCriteria> get copyWith => _$SearchCriteriaCopyWithImpl<SearchCriteria>(this as SearchCriteria, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCriteria&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,event);

@override
String toString() {
  return 'SearchCriteria(keyword: $keyword, event: $event)';
}


}

/// @nodoc
abstract mixin class $SearchCriteriaCopyWith<$Res>  {
  factory $SearchCriteriaCopyWith(SearchCriteria value, $Res Function(SearchCriteria) _then) = _$SearchCriteriaCopyWithImpl;
@useResult
$Res call({
 String keyword, Event? event
});




}
/// @nodoc
class _$SearchCriteriaCopyWithImpl<$Res>
    implements $SearchCriteriaCopyWith<$Res> {
  _$SearchCriteriaCopyWithImpl(this._self, this._then);

  final SearchCriteria _self;
  final $Res Function(SearchCriteria) _then;

/// Create a copy of SearchCriteria
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = null,Object? event = freezed,}) {
  return _then(_self.copyWith(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchCriteria].
extension SearchCriteriaPatterns on SearchCriteria {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchCriteria value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchCriteria() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchCriteria value)  $default,){
final _that = this;
switch (_that) {
case _SearchCriteria():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchCriteria value)?  $default,){
final _that = this;
switch (_that) {
case _SearchCriteria() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String keyword,  Event? event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchCriteria() when $default != null:
return $default(_that.keyword,_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String keyword,  Event? event)  $default,) {final _that = this;
switch (_that) {
case _SearchCriteria():
return $default(_that.keyword,_that.event);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String keyword,  Event? event)?  $default,) {final _that = this;
switch (_that) {
case _SearchCriteria() when $default != null:
return $default(_that.keyword,_that.event);case _:
  return null;

}
}

}

/// @nodoc


class _SearchCriteria extends SearchCriteria {
  const _SearchCriteria({this.keyword = '', this.event}): super._();
  

@override@JsonKey() final  String keyword;
@override final  Event? event;

/// Create a copy of SearchCriteria
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchCriteriaCopyWith<_SearchCriteria> get copyWith => __$SearchCriteriaCopyWithImpl<_SearchCriteria>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchCriteria&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,event);

@override
String toString() {
  return 'SearchCriteria(keyword: $keyword, event: $event)';
}


}

/// @nodoc
abstract mixin class _$SearchCriteriaCopyWith<$Res> implements $SearchCriteriaCopyWith<$Res> {
  factory _$SearchCriteriaCopyWith(_SearchCriteria value, $Res Function(_SearchCriteria) _then) = __$SearchCriteriaCopyWithImpl;
@override @useResult
$Res call({
 String keyword, Event? event
});




}
/// @nodoc
class __$SearchCriteriaCopyWithImpl<$Res>
    implements _$SearchCriteriaCopyWith<$Res> {
  __$SearchCriteriaCopyWithImpl(this._self, this._then);

  final _SearchCriteria _self;
  final $Res Function(_SearchCriteria) _then;

/// Create a copy of SearchCriteria
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = null,Object? event = freezed,}) {
  return _then(_SearchCriteria(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as Event?,
  ));
}


}

// dart format on
