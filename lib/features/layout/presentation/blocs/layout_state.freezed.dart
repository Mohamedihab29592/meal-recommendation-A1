// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LayoutState {
  LayoutStateStatus get status => throw _privateConstructorUsedError;
  int get bottomNavIndex => throw _privateConstructorUsedError;

  /// Create a copy of LayoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LayoutStateCopyWith<LayoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LayoutStateCopyWith<$Res> {
  factory $LayoutStateCopyWith(
          LayoutState value, $Res Function(LayoutState) then) =
      _$LayoutStateCopyWithImpl<$Res, LayoutState>;
  @useResult
  $Res call({LayoutStateStatus status, int bottomNavIndex});
}

/// @nodoc
class _$LayoutStateCopyWithImpl<$Res, $Val extends LayoutState>
    implements $LayoutStateCopyWith<$Res> {
  _$LayoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LayoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bottomNavIndex = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LayoutStateStatus,
      bottomNavIndex: null == bottomNavIndex
          ? _value.bottomNavIndex
          : bottomNavIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LayoutStateImplCopyWith<$Res>
    implements $LayoutStateCopyWith<$Res> {
  factory _$$LayoutStateImplCopyWith(
          _$LayoutStateImpl value, $Res Function(_$LayoutStateImpl) then) =
      __$$LayoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LayoutStateStatus status, int bottomNavIndex});
}

/// @nodoc
class __$$LayoutStateImplCopyWithImpl<$Res>
    extends _$LayoutStateCopyWithImpl<$Res, _$LayoutStateImpl>
    implements _$$LayoutStateImplCopyWith<$Res> {
  __$$LayoutStateImplCopyWithImpl(
      _$LayoutStateImpl _value, $Res Function(_$LayoutStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LayoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bottomNavIndex = null,
  }) {
    return _then(_$LayoutStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LayoutStateStatus,
      bottomNavIndex: null == bottomNavIndex
          ? _value.bottomNavIndex
          : bottomNavIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LayoutStateImpl implements _LayoutState {
  const _$LayoutStateImpl({required this.status, this.bottomNavIndex = 0});

  @override
  final LayoutStateStatus status;
  @override
  @JsonKey()
  final int bottomNavIndex;

  @override
  String toString() {
    return 'LayoutState(status: $status, bottomNavIndex: $bottomNavIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayoutStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bottomNavIndex, bottomNavIndex) ||
                other.bottomNavIndex == bottomNavIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, bottomNavIndex);

  /// Create a copy of LayoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LayoutStateImplCopyWith<_$LayoutStateImpl> get copyWith =>
      __$$LayoutStateImplCopyWithImpl<_$LayoutStateImpl>(this, _$identity);
}

abstract class _LayoutState implements LayoutState {
  const factory _LayoutState(
      {required final LayoutStateStatus status,
      final int bottomNavIndex}) = _$LayoutStateImpl;

  @override
  LayoutStateStatus get status;
  @override
  int get bottomNavIndex;

  /// Create a copy of LayoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LayoutStateImplCopyWith<_$LayoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
