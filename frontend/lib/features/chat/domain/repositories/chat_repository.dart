import '../entities/direct_chat_entity.dart';

abstract class ChatRepository {
  Future<List<DirectChatEntity>> getChats();
}