import 'package:fakegram/features/chat/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> getMessages({
    required String userId,
    required int page,
    required int limit,
  });

}