// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenRequestDTO {
  @JsonKey(name: "refresh_rotate")
  bool get refreshRotate;
  @JsonKey(name: "refresh_token")
  String get refreshToken;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenRequestDTOCopyWith<TokenRequestDTO> get copyWith =>
      _$TokenRequestDTOCopyWithImpl<TokenRequestDTO>(
          this as TokenRequestDTO, _$identity);

  /// Serializes this TokenRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenRequestDTO &&
            (identical(other.refreshRotate, refreshRotate) ||
                other.refreshRotate == refreshRotate) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshRotate, refreshToken);

  @override
  String toString() {
    return 'TokenRequestDTO(refreshRotate: $refreshRotate, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $TokenRequestDTOCopyWith<$Res> {
  factory $TokenRequestDTOCopyWith(
          TokenRequestDTO value, $Res Function(TokenRequestDTO) _then) =
      _$TokenRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "refresh_rotate") bool refreshRotate,
      @JsonKey(name: "refresh_token") String refreshToken});
}

/// @nodoc
class _$TokenRequestDTOCopyWithImpl<$Res>
    implements $TokenRequestDTOCopyWith<$Res> {
  _$TokenRequestDTOCopyWithImpl(this._self, this._then);

  final TokenRequestDTO _self;
  final $Res Function(TokenRequestDTO) _then;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshRotate = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      refreshRotate: null == refreshRotate
          ? _self.refreshRotate
          : refreshRotate // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TokenRequestDTO implements TokenRequestDTO {
  const _TokenRequestDTO(
      {@JsonKey(name: "refresh_rotate") required this.refreshRotate,
      @JsonKey(name: "refresh_token") required this.refreshToken});
  factory _TokenRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestDTOFromJson(json);

  @override
  @JsonKey(name: "refresh_rotate")
  final bool refreshRotate;
  @override
  @JsonKey(name: "refresh_token")
  final String refreshToken;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenRequestDTOCopyWith<_TokenRequestDTO> get copyWith =>
      __$TokenRequestDTOCopyWithImpl<_TokenRequestDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenRequestDTO &&
            (identical(other.refreshRotate, refreshRotate) ||
                other.refreshRotate == refreshRotate) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshRotate, refreshToken);

  @override
  String toString() {
    return 'TokenRequestDTO(refreshRotate: $refreshRotate, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$TokenRequestDTOCopyWith<$Res>
    implements $TokenRequestDTOCopyWith<$Res> {
  factory _$TokenRequestDTOCopyWith(
          _TokenRequestDTO value, $Res Function(_TokenRequestDTO) _then) =
      __$TokenRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "refresh_rotate") bool refreshRotate,
      @JsonKey(name: "refresh_token") String refreshToken});
}

/// @nodoc
class __$TokenRequestDTOCopyWithImpl<$Res>
    implements _$TokenRequestDTOCopyWith<$Res> {
  __$TokenRequestDTOCopyWithImpl(this._self, this._then);

  final _TokenRequestDTO _self;
  final $Res Function(_TokenRequestDTO) _then;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? refreshRotate = null,
    Object? refreshToken = null,
  }) {
    return _then(_TokenRequestDTO(
      refreshRotate: null == refreshRotate
          ? _self.refreshRotate
          : refreshRotate // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
