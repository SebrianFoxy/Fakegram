// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationRequestDTO {
  @JsonKey(name: "email")
  String get email;
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "surname")
  String get surname;
  @JsonKey(name: "nickname")
  String get nickname;
  @JsonKey(name: "password")
  String get password;

  /// Create a copy of RegistrationRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegistrationRequestDTOCopyWith<RegistrationRequestDTO> get copyWith =>
      _$RegistrationRequestDTOCopyWithImpl<RegistrationRequestDTO>(
          this as RegistrationRequestDTO, _$identity);

  /// Serializes this RegistrationRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegistrationRequestDTO &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, name, surname, nickname, password);

  @override
  String toString() {
    return 'RegistrationRequestDTO(email: $email, name: $name, surname: $surname, nickname: $nickname, password: $password)';
  }
}

/// @nodoc
abstract mixin class $RegistrationRequestDTOCopyWith<$Res> {
  factory $RegistrationRequestDTOCopyWith(RegistrationRequestDTO value,
          $Res Function(RegistrationRequestDTO) _then) =
      _$RegistrationRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "email") String email,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "surname") String surname,
      @JsonKey(name: "nickname") String nickname,
      @JsonKey(name: "password") String password});
}

/// @nodoc
class _$RegistrationRequestDTOCopyWithImpl<$Res>
    implements $RegistrationRequestDTOCopyWith<$Res> {
  _$RegistrationRequestDTOCopyWithImpl(this._self, this._then);

  final RegistrationRequestDTO _self;
  final $Res Function(RegistrationRequestDTO) _then;

  /// Create a copy of RegistrationRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RegistrationRequestDTO].
extension RegistrationRequestDTOPatterns on RegistrationRequestDTO {
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
    TResult Function(_RegistrationRequestDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO() when $default != null:
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
    TResult Function(_RegistrationRequestDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO():
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
    TResult? Function(_RegistrationRequestDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO() when $default != null:
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
    TResult Function(
            @JsonKey(name: "email") String email,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "surname") String surname,
            @JsonKey(name: "nickname") String nickname,
            @JsonKey(name: "password") String password)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO() when $default != null:
        return $default(_that.email, _that.name, _that.surname, _that.nickname,
            _that.password);
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
    TResult Function(
            @JsonKey(name: "email") String email,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "surname") String surname,
            @JsonKey(name: "nickname") String nickname,
            @JsonKey(name: "password") String password)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO():
        return $default(_that.email, _that.name, _that.surname, _that.nickname,
            _that.password);
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
    TResult? Function(
            @JsonKey(name: "email") String email,
            @JsonKey(name: "name") String name,
            @JsonKey(name: "surname") String surname,
            @JsonKey(name: "nickname") String nickname,
            @JsonKey(name: "password") String password)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegistrationRequestDTO() when $default != null:
        return $default(_that.email, _that.name, _that.surname, _that.nickname,
            _that.password);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegistrationRequestDTO implements RegistrationRequestDTO {
  const _RegistrationRequestDTO(
      {@JsonKey(name: "email") required this.email,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "surname") required this.surname,
      @JsonKey(name: "nickname") required this.nickname,
      @JsonKey(name: "password") required this.password});
  factory _RegistrationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestDTOFromJson(json);

  @override
  @JsonKey(name: "email")
  final String email;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "surname")
  final String surname;
  @override
  @JsonKey(name: "nickname")
  final String nickname;
  @override
  @JsonKey(name: "password")
  final String password;

  /// Create a copy of RegistrationRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegistrationRequestDTOCopyWith<_RegistrationRequestDTO> get copyWith =>
      __$RegistrationRequestDTOCopyWithImpl<_RegistrationRequestDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegistrationRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegistrationRequestDTO &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, name, surname, nickname, password);

  @override
  String toString() {
    return 'RegistrationRequestDTO(email: $email, name: $name, surname: $surname, nickname: $nickname, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$RegistrationRequestDTOCopyWith<$Res>
    implements $RegistrationRequestDTOCopyWith<$Res> {
  factory _$RegistrationRequestDTOCopyWith(_RegistrationRequestDTO value,
          $Res Function(_RegistrationRequestDTO) _then) =
      __$RegistrationRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "email") String email,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "surname") String surname,
      @JsonKey(name: "nickname") String nickname,
      @JsonKey(name: "password") String password});
}

/// @nodoc
class __$RegistrationRequestDTOCopyWithImpl<$Res>
    implements _$RegistrationRequestDTOCopyWith<$Res> {
  __$RegistrationRequestDTOCopyWithImpl(this._self, this._then);

  final _RegistrationRequestDTO _self;
  final $Res Function(_RegistrationRequestDTO) _then;

  /// Create a copy of RegistrationRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? password = null,
  }) {
    return _then(_RegistrationRequestDTO(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
