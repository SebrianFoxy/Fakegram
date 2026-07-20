import '../entities/direct_chat_entity.dart';

abstract class ChatRepository {
  Future<List<DirectChatEntity>> getChats();

  Future<List<DirectChatEntity>> searchChats({
    required String query,
    required int offset,
    required int limit,
  });
}