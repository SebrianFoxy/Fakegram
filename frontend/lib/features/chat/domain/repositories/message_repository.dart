import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/pagination_messages_entity.dart';

abstract class MessageRepository {
  Future<PaginationMessagesEntity> getInitialMessages({
    required String userId,
    @Default(null) String? cursor,
    required int limit,
  });

  Future<PaginationMessagesEntity> getOlderMessages({
    required String userId,
    required String cursor,
    required int limit,
  });

  Future<PaginationMessagesEntity> getNewerMessages({
    required String userId,
    required String cursor,
    required int limit,
  });

  Future<MessageEntity> sendMessage({
    required String chatId,
    required String messageText,
    required String messageType,
    required String replyToMessageId,
  });

  Future<void> deleteMessage({
    required String messageId
  });

  Future<MessageEntity> editMessage({
    required String messageId,
    required String newMessageText
  });
}
