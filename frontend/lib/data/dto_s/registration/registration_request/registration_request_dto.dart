import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_request_dto.freezed.dart';
part 'registration_request_dto.g.dart';

@freezed
abstract class RegistrationRequestDTO with _$RegistrationRequestDTO {
  const factory RegistrationRequestDTO ({
    @JsonKey(name: "email")
    required String email,

    @JsonKey(name: "name")
    required String name,

    @JsonKey(name: "surname")
    required String surname,

    @JsonKey(name: "nickname")
    required String nickname,

    @JsonKey(name: "password")
    required String password,

  }) = _RegistrationRequestDTO;

  factory RegistrationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestDTOFromJson(json);
}