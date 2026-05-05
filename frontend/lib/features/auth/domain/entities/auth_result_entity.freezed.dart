// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthResultEntity {
  UserEntity get user;
  TokenEntity get token;

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthResultEntityCopyWith<AuthResultEntity> get copyWith =>
      _$AuthResultEntityCopyWithImpl<AuthResultEntity>(
          this as AuthResultEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthResultEntity &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, token);

  @override
  String toString() {
    return 'AuthResultEntity(user: $user, token: $token)';
  }
}

/// @nodoc
abstract mixin class $AuthResultEntityCopyWith<$Res> {
  factory $AuthResultEntityCopyWith(
          AuthResultEntity value, $Res Function(AuthResultEntity) _then) =
      _$AuthResultEntityCopyWithImpl;
  @useResult
  $Res call({UserEntity user, TokenEntity token});

  $UserEntityCopyWith<$Res> get user;
  $TokenEntityCopyWith<$Res> get token;
}

/// @nodoc
class _$AuthResultEntityCopyWithImpl<$Res>
    implements $AuthResultEntityCopyWith<$Res> {
  _$AuthResultEntityCopyWithImpl(this._self, this._then);

  final AuthResultEntity _self;
  final $Res Function(AuthResultEntity) _then;

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? token = null,
  }) {
    return _then(_self.copyWith(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenEntity,
    ));
  }

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenEntityCopyWith<$Res> get token {
    return $TokenEntityCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AuthResultEntity].
extension AuthResultEntityPatterns on AuthResultEntity {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthResultEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthResultEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthResultEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(UserEntity user, TokenEntity token)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity() when $default != null:
        return $default(_that.user, _that.token);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(UserEntity user, TokenEntity token) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity():
        return $default(_that.user, _that.token);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(UserEntity user, TokenEntity token)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthResultEntity() when $default != null:
        return $default(_that.user, _that.token);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AuthResultEntity extends AuthResultEntity {
  const _AuthResultEntity({required this.user, required this.token})
      : super._();

  @override
  final UserEntity user;
  @override
  final TokenEntity token;

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthResultEntityCopyWith<_AuthResultEntity> get copyWith =>
      __$AuthResultEntityCopyWithImpl<_AuthResultEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthResultEntity &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, token);

  @override
  String toString() {
    return 'AuthResultEntity(user: $user, token: $token)';
  }
}

/// @nodoc
abstract mixin class _$AuthResultEntityCopyWith<$Res>
    implements $AuthResultEntityCopyWith<$Res> {
  factory _$AuthResultEntityCopyWith(
          _AuthResultEntity value, $Res Function(_AuthResultEntity) _then) =
      __$AuthResultEntityCopyWithImpl;
  @override
  @useResult
  $Res call({UserEntity user, TokenEntity token});

  @override
  $UserEntityCopyWith<$Res> get user;
  @override
  $TokenEntityCopyWith<$Res> get token;
}

/// @nodoc
class __$AuthResultEntityCopyWithImpl<$Res>
    implements _$AuthResultEntityCopyWith<$Res> {
  __$AuthResultEntityCopyWithImpl(this._self, this._then);

  final _AuthResultEntity _self;
  final $Res Function(_AuthResultEntity) _then;

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
    Object? token = null,
  }) {
    return _then(_AuthResultEntity(
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenEntity,
    ));
  }

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of AuthResultEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenEntityCopyWith<$Res> get token {
    return $TokenEntityCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

// dart format on
