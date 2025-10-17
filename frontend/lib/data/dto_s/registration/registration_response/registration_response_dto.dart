import 'package:freezed_annotation/freezed_annotation.dart';

import '../../login/login_response/login_response_dto.dart';

part 'registration_response_dto.freezed.dart';
part 'registration_response_dto.g.dart';

@freezed
abstract class RegistrationResponseDTO with _$RegistrationResponseDTO {
  const factory RegistrationResponseDTO({
    @JsonKey(name: "error") String? error,

  }) = _RegistrationResponseDTO;

  factory RegistrationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseDTOFromJson(json);
}