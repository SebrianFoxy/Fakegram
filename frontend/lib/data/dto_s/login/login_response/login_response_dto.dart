// login_response_dto.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDTO with _$LoginResponseDTO {
  const factory LoginResponseDTO({
    @JsonKey(name: "token") required TokenDTO token,
    @JsonKey(name: "user") required UserDTO user,
  }) = _LoginResponseDTO;

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);
}

@freezed
abstract class TokenDTO with _$TokenDTO {
  const factory TokenDTO({
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "refresh_token") required String refreshToken,
    @JsonKey(name: "token_type") required String tokenType,
    @JsonKey(name: "expires_in") required int expiresIn,
  }) = _TokenDTO;

  factory TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);
}

@freezed
abstract class UserDTO with _$UserDTO {
  const factory UserDTO({
    required String id,
    required String email,
    required String name,
    required String surname,
    @Default(false) bool approved,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}