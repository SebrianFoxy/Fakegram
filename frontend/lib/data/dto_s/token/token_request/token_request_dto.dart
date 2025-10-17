import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_request_dto.freezed.dart';
part 'token_request_dto.g.dart';

@freezed
abstract class TokenRequestDTO with _$TokenRequestDTO {
  const factory TokenRequestDTO ({
    @JsonKey(name: "refresh_rotate")
    required bool refreshRotate,

    @JsonKey(name: "refresh_token")
    required String refreshToken,

  }) = _TokenRequestDTO;

  factory TokenRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestDTOFromJson(json);
}