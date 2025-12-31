import 'package:fakegram/features/auth/data/models/token_dto.dart';
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
