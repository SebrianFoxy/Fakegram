// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenRequestDTO _$TokenRequestDTOFromJson(Map<String, dynamic> json) =>
    _TokenRequestDTO(
      refreshRotate: json['refresh_rotate'] as bool,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokenRequestDTOToJson(_TokenRequestDTO instance) =>
    <String, dynamic>{
      'refresh_rotate': instance.refreshRotate,
      'refresh_token': instance.refreshToken,
    };
