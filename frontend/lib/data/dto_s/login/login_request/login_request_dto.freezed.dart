// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequestDTO {
  @JsonKey(name: "email")
  String get email;
  @JsonKey(name: "password")
  String get password;

  /// Create a copy of LoginRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginRequestDTOCopyWith<LoginRequestDTO> get copyWith =>
      _$LoginRequestDTOCopyWithImpl<LoginRequestDTO>(
          this as LoginRequestDTO, _$identity);

  /// Serializes this LoginRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginRequestDTO &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @override
  String toString() {
    return 'LoginRequestDTO(email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $LoginRequestDTOCopyWith<$Res> {
  factory $LoginRequestDTOCopyWith(
          LoginRequestDTO value, $Res Function(LoginRequestDTO) _then) =
      _$LoginRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "email") String email,
      @JsonKey(name: "password") String password});
}

/// @nodoc
class _$LoginRequestDTOCopyWithImpl<$Res>
    implements $LoginRequestDTOCopyWith<$Res> {
  _$LoginRequestDTOCopyWithImpl(this._self, this._then);

  final LoginRequestDTO _self;
  final $Res Function(LoginRequestDTO) _then;

  /// Create a copy of LoginRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LoginRequestDTO implements LoginRequestDTO {
  const _LoginRequestDTO(
      {@JsonKey(name: "email") required this.email,
      @JsonKey(name: "password") required this.password});
  factory _LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);

  @override
  @JsonKey(name: "email")
  final String email;
  @override
  @JsonKey(name: "password")
  final String password;

  /// Create a copy of LoginRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginRequestDTOCopyWith<_LoginRequestDTO> get copyWith =>
      __$LoginRequestDTOCopyWithImpl<_LoginRequestDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginRequestDTO &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @override
  String toString() {
    return 'LoginRequestDTO(email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$LoginRequestDTOCopyWith<$Res>
    implements $LoginRequestDTOCopyWith<$Res> {
  factory _$LoginRequestDTOCopyWith(
          _LoginRequestDTO value, $Res Function(_LoginRequestDTO) _then) =
      __$LoginRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "email") String email,
      @JsonKey(name: "password") String password});
}

/// @nodoc
class __$LoginRequestDTOCopyWithImpl<$Res>
    implements _$LoginRequestDTOCopyWith<$Res> {
  __$LoginRequestDTOCopyWithImpl(this._self, this._then);

  final _LoginRequestDTO _self;
  final $Res Function(_LoginRequestDTO) _then;

  /// Create a copy of LoginRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_LoginRequestDTO(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
