// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatUserModel _$ChatUserModelFromJson(Map<String, dynamic> json) =>
    _ChatUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      approved: json['approved'] as bool,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isOnline: json['is_online'] as bool,
      lastSeen: DateTime.parse(json['last_seen'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ChatUserModelToJson(_ChatUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'email': instance.email,
      'approved': instance.approved,
      'bio': instance.bio,
      'avatar_url': instance.avatarUrl,
      'is_online': instance.isOnline,
      'last_seen': instance.lastSeen.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
