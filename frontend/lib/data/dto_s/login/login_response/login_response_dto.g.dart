// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    _LoginResponseDTO(
      token: TokenDTO.fromJson(json['token'] as Map<String, dynamic>),
      user: UserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDTOToJson(_LoginResponseDTO instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

_TokenDTO _$TokenDTOFromJson(Map<String, dynamic> json) => _TokenDTO(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
    );

Map<String, dynamic> _$TokenDTOToJson(_TokenDTO instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };

_UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => _UserDTO(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      approved: json['approved'] as bool? ?? false,
    );

Map<String, dynamic> _$UserDTOToJson(_UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'approved': instance.approved,
    };
