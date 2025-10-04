// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainState {
  int? get selectedEventId => throw _privateConstructorUsedError;
  int? get selectedSessionId => throw _privateConstructorUsedError;
  int? get selectedPlayerGroupId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
  @useResult
  $Res call(
      {int? selectedEventId,
      int? selectedSessionId,
      int? selectedPlayerGroupId});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedEventId = freezed,
    Object? selectedSessionId = freezed,
    Object? selectedPlayerGroupId = freezed,
  }) {
    return _then(_value.copyWith(
      selectedEventId: freezed == selectedEventId
          ? _value.selectedEventId
          : selectedEventId // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedSessionId: freezed == selectedSessionId
          ? _value.selectedSessionId
          : selectedSessionId // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedPlayerGroupId: freezed == selectedPlayerGroupId
          ? _value.selectedPlayerGroupId
          : selectedPlayerGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainStateImplCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$MainStateImplCopyWith(
          _$MainStateImpl value, $Res Function(_$MainStateImpl) then) =
      __$$MainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? selectedEventId,
      int? selectedSessionId,
      int? selectedPlayerGroupId});
}

/// @nodoc
class __$$MainStateImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainStateImpl>
    implements _$$MainStateImplCopyWith<$Res> {
  __$$MainStateImplCopyWithImpl(
      _$MainStateImpl _value, $Res Function(_$MainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedEventId = freezed,
    Object? selectedSessionId = freezed,
    Object? selectedPlayerGroupId = freezed,
  }) {
    return _then(_$MainStateImpl(
      selectedEventId: freezed == selectedEventId
          ? _value.selectedEventId
          : selectedEventId // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedSessionId: freezed == selectedSessionId
          ? _value.selectedSessionId
          : selectedSessionId // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedPlayerGroupId: freezed == selectedPlayerGroupId
          ? _value.selectedPlayerGroupId
          : selectedPlayerGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$MainStateImpl extends _MainState {
  const _$MainStateImpl(
      {this.selectedEventId,
      this.selectedSessionId,
      this.selectedPlayerGroupId})
      : super._();

  @override
  final int? selectedEventId;
  @override
  final int? selectedSessionId;
  @override
  final int? selectedPlayerGroupId;

  @override
  String toString() {
    return 'MainState(selectedEventId: $selectedEventId, selectedSessionId: $selectedSessionId, selectedPlayerGroupId: $selectedPlayerGroupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainStateImpl &&
            (identical(other.selectedEventId, selectedEventId) ||
                other.selectedEventId == selectedEventId) &&
            (identical(other.selectedSessionId, selectedSessionId) ||
                other.selectedSessionId == selectedSessionId) &&
            (identical(other.selectedPlayerGroupId, selectedPlayerGroupId) ||
                other.selectedPlayerGroupId == selectedPlayerGroupId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedEventId, selectedSessionId, selectedPlayerGroupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      __$$MainStateImplCopyWithImpl<_$MainStateImpl>(this, _$identity);
}

abstract class _MainState extends MainState {
  const factory _MainState(
      {final int? selectedEventId,
      final int? selectedSessionId,
      final int? selectedPlayerGroupId}) = _$MainStateImpl;
  const _MainState._() : super._();

  @override
  int? get selectedEventId;
  @override
  int? get selectedSessionId;
  @override
  int? get selectedPlayerGroupId;
  @override
  @JsonKey(ignore: true)
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
