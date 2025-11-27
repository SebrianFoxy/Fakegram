import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_chat_model.freezed.dart';
part 'direct_chat_model.g.dart';

@freezed
abstract class DirectChatModel with _$DirectChatModel {
  const factory DirectChatModel({
    required String id,
    @JsonKey(name: 'chat_type') required String chatType,
    required String title,
    @JsonKey(name: 'last_message') required LastMessage lastMessage,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'other_user') required ChatUser otherUser,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _DirectChatModel;

  factory DirectChatModel.fromJson(Map<String, dynamic> json) => _$DirectChatModelFromJson(json);
}

@freezed
abstract class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String id,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'message_text') required String messageText,
    @JsonKey(name: 'message_type') required String messageType,
    @JsonKey(name: 'is_edited') required bool isEdited,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);
}

@freezed
abstract class ChatUser with _$ChatUser {
  const factory ChatUser({
    required String id,
    required String name,
    required String surname,
    required String nickname,
    required String email,
    required bool approved,
    required String? bio,
    @JsonKey(name: 'avatar_url') required String? avatarUrl,
    @JsonKey(name: 'is_online') required bool isOnline,
    @JsonKey(name: 'last_seen') required DateTime lastSeen,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ChatUser;

  factory ChatUser.fromJson(Map<String, dynamic> json) => _$ChatUserFromJson(json);
}