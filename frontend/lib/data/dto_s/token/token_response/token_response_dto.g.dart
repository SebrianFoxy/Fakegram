// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenResponseDTO _$TokenResponseDTOFromJson(Map<String, dynamic> json) =>
    _TokenResponseDTO(
      token: TokenDTO.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenResponseDTOToJson(_TokenResponseDTO instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

_TokenDTO _$TokenDTOFromJson(Map<String, dynamic> json) => _TokenDTO(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokenDTOToJson(_TokenDTO instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
