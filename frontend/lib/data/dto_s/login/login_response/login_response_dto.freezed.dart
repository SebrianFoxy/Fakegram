// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

/// @nodoc
@JsonSerializable()
class _LoginResponseDTO implements LoginResponseDTO {
  const _LoginResponseDTO(
      {@JsonKey(name: "token") required this.token,
      @JsonKey(name: "user") required this.user});
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

/// @nodoc
mixin _$TokenDTO {
  @JsonKey(name: "access_token")
  String get accessToken;
  @JsonKey(name: "refresh_token")
  String get refreshToken;
  @JsonKey(name: "token_type")
  String get tokenType;
  @JsonKey(name: "expires_in")
  int get expiresIn;

  /// Create a copy of TokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<TokenDTO> get copyWith =>
      _$TokenDTOCopyWithImpl<TokenDTO>(this as TokenDTO, _$identity);

  /// Serializes this TokenDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenDTO &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, tokenType, expiresIn);

  @override
  String toString() {
    return 'TokenDTO(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn)';
  }
}

/// @nodoc
abstract mixin class $TokenDTOCopyWith<$Res> {
  factory $TokenDTOCopyWith(TokenDTO value, $Res Function(TokenDTO) _then) =
      _$TokenDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "access_token") String accessToken,
      @JsonKey(name: "refresh_token") String refreshToken,
      @JsonKey(name: "token_type") String tokenType,
      @JsonKey(name: "expires_in") int expiresIn});
}

/// @nodoc
class _$TokenDTOCopyWithImpl<$Res> implements $TokenDTOCopyWith<$Res> {
  _$TokenDTOCopyWithImpl(this._self, this._then);

  final TokenDTO _self;
  final $Res Function(TokenDTO) _then;

  /// Create a copy of TokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? tokenType = null,
    Object? expiresIn = null,
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
      tokenType: null == tokenType
          ? _self.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TokenDTO implements TokenDTO {
  const _TokenDTO(
      {@JsonKey(name: "access_token") required this.accessToken,
      @JsonKey(name: "refresh_token") required this.refreshToken,
      @JsonKey(name: "token_type") required this.tokenType,
      @JsonKey(name: "expires_in") required this.expiresIn});
  factory _TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);

  @override
  @JsonKey(name: "access_token")
  final String accessToken;
  @override
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @override
  @JsonKey(name: "token_type")
  final String tokenType;
  @override
  @JsonKey(name: "expires_in")
  final int expiresIn;

  /// Create a copy of TokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenDTOCopyWith<_TokenDTO> get copyWith =>
      __$TokenDTOCopyWithImpl<_TokenDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenDTO &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, tokenType, expiresIn);

  @override
  String toString() {
    return 'TokenDTO(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn)';
  }
}

/// @nodoc
abstract mixin class _$TokenDTOCopyWith<$Res>
    implements $TokenDTOCopyWith<$Res> {
  factory _$TokenDTOCopyWith(_TokenDTO value, $Res Function(_TokenDTO) _then) =
      __$TokenDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "access_token") String accessToken,
      @JsonKey(name: "refresh_token") String refreshToken,
      @JsonKey(name: "token_type") String tokenType,
      @JsonKey(name: "expires_in") int expiresIn});
}

/// @nodoc
class __$TokenDTOCopyWithImpl<$Res> implements _$TokenDTOCopyWith<$Res> {
  __$TokenDTOCopyWithImpl(this._self, this._then);

  final _TokenDTO _self;
  final $Res Function(_TokenDTO) _then;

  /// Create a copy of TokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? tokenType = null,
    Object? expiresIn = null,
  }) {
    return _then(_TokenDTO(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _self.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$UserDTO {
  String get id;
  String get email;
  String get name;
  String get surname;
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
            (identical(other.approved, approved) ||
                other.approved == approved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, name, surname, approved);

  @override
  String toString() {
    return 'UserDTO(id: $id, email: $email, name: $name, surname: $surname, approved: $approved)';
  }
}

/// @nodoc
abstract mixin class $UserDTOCopyWith<$Res> {
  factory $UserDTOCopyWith(UserDTO value, $Res Function(UserDTO) _then) =
      _$UserDTOCopyWithImpl;
  @useResult
  $Res call(
      {String id, String email, String name, String surname, bool approved});
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
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserDTO implements UserDTO {
  const _UserDTO(
      {required this.id,
      required this.email,
      required this.name,
      required this.surname,
      this.approved = false});
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
            (identical(other.approved, approved) ||
                other.approved == approved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, name, surname, approved);

  @override
  String toString() {
    return 'UserDTO(id: $id, email: $email, name: $name, surname: $surname, approved: $approved)';
  }
}

/// @nodoc
abstract mixin class _$UserDTOCopyWith<$Res> implements $UserDTOCopyWith<$Res> {
  factory _$UserDTOCopyWith(_UserDTO value, $Res Function(_UserDTO) _then) =
      __$UserDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String email, String name, String surname, bool approved});
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
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
