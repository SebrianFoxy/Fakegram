import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user_entity.freezed.dart';

@freezed
abstract class ChatUserEntity with _$ChatUserEntity {
  const factory ChatUserEntity({
    required String id,
    required String name,
    required String surname,
    required String nickname,
    required String email,
    required bool approved,
    required String? bio,
    required String? avatarUrl,
    required bool isOnline,
    required DateTime lastSeen,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatUserEntity;

  const ChatUserEntity._();
}