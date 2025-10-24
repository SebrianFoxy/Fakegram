// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenResponseDTO _$TokenResponseDTOFromJson(Map<String, dynamic> json) =>
    _TokenResponseDTO(
      token: TokenModel.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenResponseDTOToJson(_TokenResponseDTO instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
