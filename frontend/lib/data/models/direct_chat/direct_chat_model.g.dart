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
      lastMessage:
          LastMessage.fromJson(json['last_message'] as Map<String, dynamic>),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      otherUser: ChatUser.fromJson(json['other_user'] as Map<String, dynamic>),
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

_LastMessage _$LastMessageFromJson(Map<String, dynamic> json) => _LastMessage(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      messageText: json['message_text'] as String,
      messageType: json['message_type'] as String,
      isEdited: json['is_edited'] as bool,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LastMessageToJson(_LastMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'sender_id': instance.senderId,
      'message_text': instance.messageText,
      'message_type': instance.messageType,
      'is_edited': instance.isEdited,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
    };

_ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => _ChatUser(
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

Map<String, dynamic> _$ChatUserToJson(_ChatUser instance) => <String, dynamic>{
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
