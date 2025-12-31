// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => _UserDTO(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      nickname: json['nickname'] as String,
      approved: json['approved'] as bool? ?? false,
    );

Map<String, dynamic> _$UserDTOToJson(_UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'approved': instance.approved,
    };
