import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

enum MessageStatus {
  none,
  sending,
  sent,
  read,
  error
}

@freezed
abstract class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,
    required String chatId,
    required String senderId,
    required String messageText,
    required String messageType,
    required String? replyToMessageId,
    MessageEntity? replyToMessage,
    required bool isEdited,
    required bool isDeleted,
    required bool isRead,
    required DateTime createdAt,
    required DateTime? readAt,
    required String senderName,
    required String senderSurname,
    required String senderNickname,
    required String? senderAvatarUrl,
    @Default(MessageStatus.none) MessageStatus status,
  }) = _MessageEntity;

  const MessageEntity._();
}