import 'package:freezed_annotation/freezed_annotation.dart';
import 'chat_user_entity.dart';
import 'last_message_entity.dart';

part 'direct_chat_entity.freezed.dart';

@freezed
abstract class DirectChatEntity with _$DirectChatEntity {
  const factory DirectChatEntity({
    required String id,
    required String chatType,
    required String title,
    required LastMessageEntity lastMessage,
    @Default(0) int unreadCount,
    required ChatUserEntity otherUser,
    required DateTime updatedAt,
  }) = _DirectChatEntity;

  const DirectChatEntity._();
}