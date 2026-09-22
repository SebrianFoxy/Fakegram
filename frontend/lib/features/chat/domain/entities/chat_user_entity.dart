import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user_entity.freezed.dart';

@freezed
abstract class ChatUserEntity with _$ChatUserEntity {
  const factory ChatUserEntity({
    required String id,
    @Default('') String name,
    @Default('') String surname,
    @Default('') String nickname,
    @Default('') String email,
    @Default(false) bool approved,
    String? bio,
    String? avatarUrl,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatUserEntity;

  const ChatUserEntity._();
}