import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_chat_model.freezed.dart';
part 'direct_chat_model.g.dart';

@freezed
abstract class DirectChatModel with _$DirectChatModel {
  const factory DirectChatModel({
    required String id,
    required String otherUserId,
    required String otherUserName,
    required String otherUserAvatar,
    required String lastMessage,
    required String lastMessageTime,
    @Default(0) int unreadCount,
    required bool isOnline,
    DateTime? createdAt,
  }) = _DirectChatModel;

  factory DirectChatModel.fromJson(Map<String, dynamic> json) => _$DirectChatModelFromJson(json);
}