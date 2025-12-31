import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/token_entity.dart';

part 'token_dto.freezed.dart';
part 'token_dto.g.dart';

@freezed
abstract class TokenDTO with _$TokenDTO {
  const TokenDTO._();

  const factory TokenDTO({
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "refresh_token") required String refreshToken,
  }) = _TokenDTO;

  factory TokenDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenDTOFromJson(json);

  TokenEntity toEntity() {
    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}