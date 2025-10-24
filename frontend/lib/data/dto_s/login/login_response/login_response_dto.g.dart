// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    _LoginResponseDTO(
      token: TokenModel.fromJson(json['token'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDTOToJson(_LoginResponseDTO instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
