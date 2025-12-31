import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../token_dto.dart';
import '../user_dto.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDTO with _$LoginResponseDTO {
  const LoginResponseDTO._();

  const factory LoginResponseDTO({
    @JsonKey(name: "token") required TokenDTO token,
    @JsonKey(name: "user") required UserDTO user,
  }) = _LoginResponseDTO;

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  AuthResultEntity toEntity() {
    return AuthResultEntity(
      user: user.toEntity(),
      token: token.toEntity(),
    );
  }
}
