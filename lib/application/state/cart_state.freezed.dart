// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CartState {
  Cart? get cartModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
  @useResult
  $Res call({Cart? cartModel, bool isLoading});

  $CartCopyWith<$Res>? get cartModel;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      cartModel: freezed == cartModel
          ? _value.cartModel
          : cartModel // ignore: cast_nullable_to_non_nullable
              as Cart?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CartCopyWith<$Res>? get cartModel {
    if (_value.cartModel == null) {
      return null;
    }

    return $CartCopyWith<$Res>(_value.cartModel!, (value) {
      return _then(_value.copyWith(cartModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_cartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$$_cartStateCopyWith(
          _$_cartState value, $Res Function(_$_cartState) then) =
      __$$_cartStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Cart? cartModel, bool isLoading});

  @override
  $CartCopyWith<$Res>? get cartModel;
}

/// @nodoc
class __$$_cartStateCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$_cartState>
    implements _$$_cartStateCopyWith<$Res> {
  __$$_cartStateCopyWithImpl(
      _$_cartState _value, $Res Function(_$_cartState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_cartState(
      cartModel: freezed == cartModel
          ? _value.cartModel
          : cartModel // ignore: cast_nullable_to_non_nullable
              as Cart?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_cartState implements _cartState {
  const _$_cartState({this.cartModel, this.isLoading = false});

  @override
  final Cart? cartModel;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'CartState(cartModel: $cartModel, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_cartState &&
            (identical(other.cartModel, cartModel) ||
                other.cartModel == cartModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cartModel, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_cartStateCopyWith<_$_cartState> get copyWith =>
      __$$_cartStateCopyWithImpl<_$_cartState>(this, _$identity);
}

abstract class _cartState implements CartState {
  const factory _cartState({final Cart? cartModel, final bool isLoading}) =
      _$_cartState;

  @override
  Cart? get cartModel;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_cartStateCopyWith<_$_cartState> get copyWith =>
      throw _privateConstructorUsedError;
}
