// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginResponseDTO {
  @JsonKey(name: "token")
  TokenDTO get token;
  @JsonKey(name: "user")
  UserDTO get user;

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginResponseDTOCopyWith<LoginResponseDTO> get copyWith =>
      _$LoginResponseDTOCopyWithImpl<LoginResponseDTO>(
          this as LoginResponseDTO, _$identity);

  /// Serializes this LoginResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginResponseDTO &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, user);

  @override
  String toString() {
    return 'LoginResponseDTO(token: $token, user: $user)';
  }
}

/// @nodoc
abstract mixin class $LoginResponseDTOCopyWith<$Res> {
  factory $LoginResponseDTOCopyWith(
          LoginResponseDTO value, $Res Function(LoginResponseDTO) _then) =
      _$LoginResponseDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "token") TokenDTO token,
      @JsonKey(name: "user") UserDTO user});

  $TokenDTOCopyWith<$Res> get token;
  $UserDTOCopyWith<$Res> get user;
}

/// @nodoc
class _$LoginResponseDTOCopyWithImpl<$Res>
    implements $LoginResponseDTOCopyWith<$Res> {
  _$LoginResponseDTOCopyWithImpl(this._self, this._then);

  final LoginResponseDTO _self;
  final $Res Function(LoginResponseDTO) _then;

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDTO,
    ));
  }

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<$Res> get token {
    return $TokenDTOCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDTOCopyWith<$Res> get user {
    return $UserDTOCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LoginResponseDTO].
extension LoginResponseDTOPatterns on LoginResponseDTO {
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
    TResult Function(_LoginResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO() when $default != null:
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
    TResult Function(_LoginResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO():
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
    TResult? Function(_LoginResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO() when $default != null:
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
    TResult Function(@JsonKey(name: "token") TokenDTO token,
            @JsonKey(name: "user") UserDTO user)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO() when $default != null:
        return $default(_that.token, _that.user);
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
    TResult Function(@JsonKey(name: "token") TokenDTO token,
            @JsonKey(name: "user") UserDTO user)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO():
        return $default(_that.token, _that.user);
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
    TResult? Function(@JsonKey(name: "token") TokenDTO token,
            @JsonKey(name: "user") UserDTO user)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginResponseDTO() when $default != null:
        return $default(_that.token, _that.user);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LoginResponseDTO extends LoginResponseDTO {
  const _LoginResponseDTO(
      {@JsonKey(name: "token") required this.token,
      @JsonKey(name: "user") required this.user})
      : super._();
  factory _LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  @override
  @JsonKey(name: "token")
  final TokenDTO token;
  @override
  @JsonKey(name: "user")
  final UserDTO user;

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginResponseDTOCopyWith<_LoginResponseDTO> get copyWith =>
      __$LoginResponseDTOCopyWithImpl<_LoginResponseDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginResponseDTO &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, user);

  @override
  String toString() {
    return 'LoginResponseDTO(token: $token, user: $user)';
  }
}

/// @nodoc
abstract mixin class _$LoginResponseDTOCopyWith<$Res>
    implements $LoginResponseDTOCopyWith<$Res> {
  factory _$LoginResponseDTOCopyWith(
          _LoginResponseDTO value, $Res Function(_LoginResponseDTO) _then) =
      __$LoginResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "token") TokenDTO token,
      @JsonKey(name: "user") UserDTO user});

  @override
  $TokenDTOCopyWith<$Res> get token;
  @override
  $UserDTOCopyWith<$Res> get user;
}

/// @nodoc
class __$LoginResponseDTOCopyWithImpl<$Res>
    implements _$LoginResponseDTOCopyWith<$Res> {
  __$LoginResponseDTOCopyWithImpl(this._self, this._then);

  final _LoginResponseDTO _self;
  final $Res Function(_LoginResponseDTO) _then;

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_LoginResponseDTO(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDTO,
    ));
  }

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<$Res> get token {
    return $TokenDTOCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }

  /// Create a copy of LoginResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDTOCopyWith<$Res> get user {
    return $UserDTOCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
