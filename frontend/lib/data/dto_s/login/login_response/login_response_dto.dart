import 'package:fakegram/data/models/token/token_model.dart';
import 'package:fakegram/data/models/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDTO with _$LoginResponseDTO {
  const factory LoginResponseDTO({
    @JsonKey(name: "token") required TokenModel token,
    @JsonKey(name: "user") required UserModel user,
  }) = _LoginResponseDTO;

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);
}
