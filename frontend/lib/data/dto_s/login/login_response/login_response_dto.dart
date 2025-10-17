import 'package:freezed_annotation/freezed_annotation.dart';
import '../../token/token_response/token_response_dto.dart';

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
abstract class UserDTO with _$UserDTO {
  const factory UserDTO({
    required String id,
    required String email,
    required String name,
    required String surname,
    required String nickname,
    @Default(false) bool approved,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
}