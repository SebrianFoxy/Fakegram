import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/direct_chat_entity.dart';
import 'chat_user_model.dart';
import 'last_message_model.dart';

part 'direct_chat_model.freezed.dart';
part 'direct_chat_model.g.dart';

@freezed
abstract class DirectChatModel with _$DirectChatModel {
  const factory DirectChatModel({
    required String id,
    @JsonKey(name: 'chat_type') required String chatType,
    required String title,
    @JsonKey(name: 'last_message') required LastMessageModel lastMessage,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'other_user') required ChatUserModel otherUser,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _DirectChatModel;

  const DirectChatModel._();

  factory DirectChatModel.fromJson(Map<String, dynamic> json) =>
      _$DirectChatModelFromJson(json);

  DirectChatEntity toEntity() => DirectChatEntity(
    id: id,
    chatType: chatType,
    title: title,
    lastMessage: lastMessage.toEntity(),
    unreadCount: unreadCount,
    otherUser: otherUser.toEntity(),
    updatedAt: updatedAt,
  );
}