// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DirectChatModel _$DirectChatModelFromJson(Map<String, dynamic> json) =>
    _DirectChatModel(
      id: json['id'] as String,
      otherUserId: json['otherUserId'] as String,
      otherUserName: json['otherUserName'] as String,
      otherUserAvatar: json['otherUserAvatar'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      isOnline: json['isOnline'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DirectChatModelToJson(_DirectChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'otherUserId': instance.otherUserId,
      'otherUserName': instance.otherUserName,
      'otherUserAvatar': instance.otherUserAvatar,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'unreadCount': instance.unreadCount,
      'isOnline': instance.isOnline,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
