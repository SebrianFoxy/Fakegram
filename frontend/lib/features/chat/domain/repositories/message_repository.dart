import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import '../entities/pagination_messages_entity.dart';

abstract class MessageRepository {
  Future<PaginationMessagesEntity> getInitialMessages({
    required String userId,
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
}
