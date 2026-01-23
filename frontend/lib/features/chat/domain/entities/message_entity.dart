import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
abstract class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,
    required String chatId,
    required String senderId,
    required String messageText,
    required String messageType,
    required String? replyToMessageId,
    required bool isEdited,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime? readAt,
    required String senderName,
    required String senderSurname,
    required String senderNickname,
    required String? senderAvatarUrl,
  }) = _MessageEntity;

  const MessageEntity._();
}