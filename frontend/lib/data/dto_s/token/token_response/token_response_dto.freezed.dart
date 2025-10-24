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
  TokenModel get token;

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
  $Res call({@JsonKey(name: "token") TokenModel token});

  $TokenModelCopyWith<$Res> get token;
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
              as TokenModel,
    ));
  }

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenModelCopyWith<$Res> get token {
    return $TokenModelCopyWith<$Res>(_self.token, (value) {
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
  final TokenModel token;

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
  $Res call({@JsonKey(name: "token") TokenModel token});

  @override
  $TokenModelCopyWith<$Res> get token;
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
              as TokenModel,
    ));
  }

  /// Create a copy of TokenResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenModelCopyWith<$Res> get token {
    return $TokenModelCopyWith<$Res>(_self.token, (value) {
      return _then(_self.copyWith(token: value));
    });
  }
}

// dart format on
