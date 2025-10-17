import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_response_dto.freezed.dart';
part 'token_response_dto.g.dart';

@freezed
abstract class TokenResponseDTO with _$TokenResponseDTO {
  const factory TokenResponseDTO({
    @JsonKey(name: "token") required TokenDTO token,
  }) = _TokenResponseDTO;

  factory TokenResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDTOFromJson(json);
}

@freezed
abstract class TokenDTO with _$TokenDTO {
  const factory TokenDTO({
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "refresh_token") required String refreshToken,
    // @JsonKey(name: "token_type") required String tokenType,
    // @JsonKey(name: "expires_in") required int expiresIn,
  }) = _TokenDTO;

  factory TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);
}