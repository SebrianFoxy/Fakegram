import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_user_entity.dart';


part 'chat_user_model.freezed.dart';
part 'chat_user_model.g.dart';

@freezed
abstract class ChatUserModel with _$ChatUserModel {
  const factory ChatUserModel({
    required String id,
    required String name,
    required String surname,
    required String nickname,
    required String email,
    required bool approved,
    required String? bio,
    @JsonKey(name: 'avatar_url') required String? avatarUrl,
    @JsonKey(name: 'is_online') required bool isOnline,
    @JsonKey(name: 'last_seen') required DateTime lastSeen,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ChatUserModel;

  const ChatUserModel._();

  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);

  ChatUserEntity toEntity() => ChatUserEntity(
    id: id,
    name: name,
    surname: surname,
    nickname: nickname,
    email: email,
    approved: approved,
    bio: bio,
    avatarUrl: avatarUrl,
    isOnline: isOnline,
    lastSeen: lastSeen,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}