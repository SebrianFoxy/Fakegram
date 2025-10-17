// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenResponseDTO {
  @JsonKey(name: "token")
  TokenDTO get token;

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenResponseDTOCopyWith<TokenResponseDTO> get copyWith =>
      _$TokenResponseDTOCopyWithImpl<TokenResponseDTO>(
          this as TokenResponseDTO, _$identity);

  /// Serializes this TokenResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenResponseDTO &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @override
  String toString() {
    return 'TokenResponseDTO(token: $token)';
  }
}

/// @nodoc
abstract mixin class $TokenResponseDTOCopyWith<$Res> {
  factory $TokenResponseDTOCopyWith(
          TokenResponseDTO value, $Res Function(TokenResponseDTO) _then) =
      _$TokenResponseDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: "token") TokenDTO token});

  $TokenDTOCopyWith<$Res> get token;
}

/// @nodoc
class _$TokenResponseDTOCopyWithImpl<$Res>
    implements $TokenResponseDTOCopyWith<$Res> {
  _$TokenResponseDTOCopyWithImpl(this._self, this._then);

  final TokenResponseDTO _self;
  final $Res Function(TokenResponseDTO) _then;

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_self.copyWith(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
    ));
  }

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<$Res> get token {
    return $TokenDTOCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TokenResponseDTO implements TokenResponseDTO {
  const _TokenResponseDTO({@JsonKey(name: "token") required this.token});
  factory _TokenResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDTOFromJson(json);

  @override
  @JsonKey(name: "token")
  final TokenDTO token;

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenResponseDTOCopyWith<_TokenResponseDTO> get copyWith =>
      __$TokenResponseDTOCopyWithImpl<_TokenResponseDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenResponseDTO &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @override
  String toString() {
    return 'TokenResponseDTO(token: $token)';
  }
}

/// @nodoc
abstract mixin class _$TokenResponseDTOCopyWith<$Res>
    implements $TokenResponseDTOCopyWith<$Res> {
  factory _$TokenResponseDTOCopyWith(
          _TokenResponseDTO value, $Res Function(_TokenResponseDTO) _then) =
      __$TokenResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: "token") TokenDTO token});

  @override
  $TokenDTOCopyWith<$Res> get token;
}

/// @nodoc
class __$TokenResponseDTOCopyWithImpl<$Res>
    implements _$TokenResponseDTOCopyWith<$Res> {
  __$TokenResponseDTOCopyWithImpl(this._self, this._then);

  final _TokenResponseDTO _self;
  final $Res Function(_TokenResponseDTO) _then;

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
  }) {
    return _then(_TokenResponseDTO(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenDTO,
    ));
  }

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenDTOCopyWith<$Res> get token {
    return $TokenDTOCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

/// @nodoc
mixin _$TokenDTO {
  @JsonKey(name: "access_token")
  String get accessToken;
  @JsonKey(name: "refresh_token")
  String get refreshToken;

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
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenDTO(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $TokenDTOCopyWith<$Res> {
  factory $TokenDTOCopyWith(TokenDTO value, $Res Function(TokenDTO) _then) =
      _$TokenDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "access_token") String accessToken,
      @JsonKey(name: "refresh_token") String refreshToken});
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
@JsonSerializable()
class _TokenDTO implements TokenDTO {
  const _TokenDTO(
      {@JsonKey(name: "access_token") required this.accessToken,
      @JsonKey(name: "refresh_token") required this.refreshToken});
  factory _TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);

  @override
  @JsonKey(name: "access_token")
  final String accessToken;
  @override
  @JsonKey(name: "refresh_token")
  final String refreshToken;

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
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @override
  String toString() {
    return 'TokenDTO(accessToken: $accessToken, refreshToken: $refreshToken)';
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
      @JsonKey(name: "refresh_token") String refreshToken});
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
    ));
  }
}

// dart format on
