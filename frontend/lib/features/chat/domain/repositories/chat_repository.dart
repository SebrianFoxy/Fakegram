import '../entities/direct_chat_entity.dart';

abstract class ChatRepository {
  Future<List<DirectChatEntity>> getChats();

  Future<List<DirectChatEntity>> searchChats({
    required String query,
    required int offset,
    required int limit,
  });

  Future<DirectChatEntity> createGroupChat({
    required String title,
    required List<String> membersIDs,
    String? avatarUrl,
    String? description,
  });
}