// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegistrationRequestDTO _$RegistrationRequestDTOFromJson(
        Map<String, dynamic> json) =>
    _RegistrationRequestDTO(
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      nickname: json['nickname'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegistrationRequestDTOToJson(
        _RegistrationRequestDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'password': instance.password,
    };
