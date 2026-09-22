import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/direct_chat_entity.dart';
import 'chat_user_model.dart';
import 'last_message_model.dart';

part 'direct_chat_model.freezed.dart';
part 'direct_chat_model.g.dart';

@freezed
abstract class DirectChatModel with _$DirectChatModel {
  const factory DirectChatModel({
    required String id,
    @JsonKey(name: 'chat_type') required String chatType,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'last_message') LastMessageModel? lastMessage,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'other_user') ChatUserModel? otherUser,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _DirectChatModel;

  const DirectChatModel._();

  factory DirectChatModel.fromJson(Map<String, dynamic> json) =>
      _$DirectChatModelFromJson(json);

  DirectChatEntity toEntity() => DirectChatEntity(
    id: id,
    chatType: chatType,
    title: title,
    avatarUrl: sanitizeUrl(avatarUrl),
    lastMessage: lastMessage?.toEntity(),
    unreadCount: unreadCount,
    otherUser: otherUser?.toEntity(),
    updatedAt: updatedAt,
  );
}

String? sanitizeUrl(String? url) {
  if (url == null) return null;
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;
  if (trimmed == 'string' || trimmed == 'null' || trimmed == 'undefined') {
    return null;
  }
  final uri = Uri.tryParse(trimmed);
  if (uri == null) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  if (uri.host.isEmpty) return null;
  return trimmed;
}