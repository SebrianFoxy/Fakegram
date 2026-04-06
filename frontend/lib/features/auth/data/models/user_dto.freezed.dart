// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDTO {
  String get id;
  String get email;
  String get name;
  String get surname;
  String get nickname;
  bool get approved;

  /// Create a copy of UserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDTOCopyWith<UserDTO> get copyWith =>
      _$UserDTOCopyWithImpl<UserDTO>(this as UserDTO, _$identity);

  /// Serializes this UserDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.approved, approved) ||
                other.approved == approved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, name, surname, nickname, approved);

  @override
  String toString() {
    return 'UserDTO(id: $id, email: $email, name: $name, surname: $surname, nickname: $nickname, approved: $approved)';
  }
}

/// @nodoc
abstract mixin class $UserDTOCopyWith<$Res> {
  factory $UserDTOCopyWith(UserDTO value, $Res Function(UserDTO) _then) =
      _$UserDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String surname,
      String nickname,
      bool approved});
}

/// @nodoc
class _$UserDTOCopyWithImpl<$Res> implements $UserDTOCopyWith<$Res> {
  _$UserDTOCopyWithImpl(this._self, this._then);

  final UserDTO _self;
  final $Res Function(UserDTO) _then;

  /// Create a copy of UserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? approved = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserDTO].
extension UserDTOPatterns on UserDTO {
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
    TResult Function(_UserDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDTO() when $default != null:
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
    TResult Function(_UserDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDTO():
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
    TResult? Function(_UserDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDTO() when $default != null:
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
    TResult Function(String id, String email, String name, String surname,
            String nickname, bool approved)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDTO() when $default != null:
        return $default(_that.id, _that.email, _that.name, _that.surname,
            _that.nickname, _that.approved);
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
    TResult Function(String id, String email, String name, String surname,
            String nickname, bool approved)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDTO():
        return $default(_that.id, _that.email, _that.name, _that.surname,
            _that.nickname, _that.approved);
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
    TResult? Function(String id, String email, String name, String surname,
            String nickname, bool approved)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDTO() when $default != null:
        return $default(_that.id, _that.email, _that.name, _that.surname,
            _that.nickname, _that.approved);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserDTO extends UserDTO {
  const _UserDTO(
      {required this.id,
      required this.email,
      required this.name,
      required this.surname,
      required this.nickname,
      this.approved = false})
      : super._();
  factory _UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String nickname;
  @override
  @JsonKey()
  final bool approved;

  /// Create a copy of UserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDTOCopyWith<_UserDTO> get copyWith =>
      __$UserDTOCopyWithImpl<_UserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.approved, approved) ||
                other.approved == approved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, name, surname, nickname, approved);

  @override
  String toString() {
    return 'UserDTO(id: $id, email: $email, name: $name, surname: $surname, nickname: $nickname, approved: $approved)';
  }
}

/// @nodoc
abstract mixin class _$UserDTOCopyWith<$Res> implements $UserDTOCopyWith<$Res> {
  factory _$UserDTOCopyWith(_UserDTO value, $Res Function(_UserDTO) _then) =
      __$UserDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String surname,
      String nickname,
      bool approved});
}

/// @nodoc
class __$UserDTOCopyWithImpl<$Res> implements _$UserDTOCopyWith<$Res> {
  __$UserDTOCopyWithImpl(this._self, this._then);

  final _UserDTO _self;
  final $Res Function(_UserDTO) _then;

  /// Create a copy of UserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? approved = null,
  }) {
    return _then(_UserDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
