// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenEntity {
  String get accessToken;
  String get refreshToken;

  /// Create a copy of TokenEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenEntityCopyWith<TokenEntity> get copyWith =>
      _$TokenEntityCopyWithImpl<TokenEntity>(this as TokenEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenEntity &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $TokenEntityCopyWith<$Res> {
  factory $TokenEntityCopyWith(
          TokenEntity value, $Res Function(TokenEntity) _then) =
      _$TokenEntityCopyWithImpl;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$TokenEntityCopyWithImpl<$Res> implements $TokenEntityCopyWith<$Res> {
  _$TokenEntityCopyWithImpl(this._self, this._then);

  final TokenEntity _self;
  final $Res Function(TokenEntity) _then;

  /// Create a copy of TokenEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _TokenEntity extends TokenEntity {
  const _TokenEntity({required this.accessToken, required this.refreshToken})
      : super._();

  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of TokenEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenEntityCopyWith<_TokenEntity> get copyWith =>
      __$TokenEntityCopyWithImpl<_TokenEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenEntity &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenEntity(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$TokenEntityCopyWith<$Res>
    implements $TokenEntityCopyWith<$Res> {
  factory _$TokenEntityCopyWith(
          _TokenEntity value, $Res Function(_TokenEntity) _then) =
      __$TokenEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$TokenEntityCopyWithImpl<$Res> implements _$TokenEntityCopyWith<$Res> {
  __$TokenEntityCopyWithImpl(this._self, this._then);

  final _TokenEntity _self;
  final $Res Function(_TokenEntity) _then;

  /// Create a copy of TokenEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_TokenEntity(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
