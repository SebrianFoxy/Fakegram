import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import '../entities/pagination_messages_entity.dart';

abstract class MessageRepository {
  Future<PaginationMessagesEntity> getMessages({
    required String userId,
    required int page,
    required int limit,
  });

  Future<MessageEntity> sendMessage({
    required String chatId,
    required String messageText,
    required String messageType,
    required String replyToMessageId,
  });

}