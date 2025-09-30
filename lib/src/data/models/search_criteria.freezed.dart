// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchCriteria {
  String get keyword => throw _privateConstructorUsedError;
  Event? get event => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchCriteriaCopyWith<SearchCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchCriteriaCopyWith<$Res> {
  factory $SearchCriteriaCopyWith(
          SearchCriteria value, $Res Function(SearchCriteria) then) =
      _$SearchCriteriaCopyWithImpl<$Res, SearchCriteria>;
  @useResult
  $Res call({String keyword, Event? event});
}

/// @nodoc
class _$SearchCriteriaCopyWithImpl<$Res, $Val extends SearchCriteria>
    implements $SearchCriteriaCopyWith<$Res> {
  _$SearchCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchCriteriaImplCopyWith<$Res>
    implements $SearchCriteriaCopyWith<$Res> {
  factory _$$SearchCriteriaImplCopyWith(_$SearchCriteriaImpl value,
          $Res Function(_$SearchCriteriaImpl) then) =
      __$$SearchCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String keyword, Event? event});
}

/// @nodoc
class __$$SearchCriteriaImplCopyWithImpl<$Res>
    extends _$SearchCriteriaCopyWithImpl<$Res, _$SearchCriteriaImpl>
    implements _$$SearchCriteriaImplCopyWith<$Res> {
  __$$SearchCriteriaImplCopyWithImpl(
      _$SearchCriteriaImpl _value, $Res Function(_$SearchCriteriaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? event = freezed,
  }) {
    return _then(_$SearchCriteriaImpl(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
    ));
  }
}

/// @nodoc

class _$SearchCriteriaImpl extends _SearchCriteria {
  const _$SearchCriteriaImpl({this.keyword = '', this.event}) : super._();

  @override
  @JsonKey()
  final String keyword;
  @override
  final Event? event;

  @override
  String toString() {
    return 'SearchCriteria(keyword: $keyword, event: $event)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCriteriaImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.event, event) || other.event == event));
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyword, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCriteriaImplCopyWith<_$SearchCriteriaImpl> get copyWith =>
      __$$SearchCriteriaImplCopyWithImpl<_$SearchCriteriaImpl>(
          this, _$identity);
}

abstract class _SearchCriteria extends SearchCriteria {
  const factory _SearchCriteria({final String keyword, final Event? event}) =
      _$SearchCriteriaImpl;
  const _SearchCriteria._() : super._();

  @override
  String get keyword;
  @override
  Event? get event;
  @override
  @JsonKey(ignore: true)
  _$$SearchCriteriaImplCopyWith<_$SearchCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
