import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_dto.freezed.dart';
part 'login_request_dto.g.dart';

@freezed
abstract class LoginRequestDTO with _$LoginRequestDTO {
  const factory LoginRequestDTO ({
    @JsonKey(name: "email")
    required String email,

    @JsonKey(name: "password")
    required String password,

  }) = _LoginRequestDTO;

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);
}