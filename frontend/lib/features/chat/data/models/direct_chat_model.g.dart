// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DirectChatModel _$DirectChatModelFromJson(Map<String, dynamic> json) =>
    _DirectChatModel(
      id: json['id'] as String,
      chatType: json['chat_type'] as String,
      title: json['title'] as String,
      lastMessage: LastMessageModel.fromJson(
          json['last_message'] as Map<String, dynamic>),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      otherUser:
          ChatUserModel.fromJson(json['other_user'] as Map<String, dynamic>),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DirectChatModelToJson(_DirectChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_type': instance.chatType,
      'title': instance.title,
      'last_message': instance.lastMessage,
      'unread_count': instance.unreadCount,
      'other_user': instance.otherUser,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
