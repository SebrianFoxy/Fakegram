import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/message_entity.dart';

part 'message_detail_model.freezed.dart';
part 'message_detail_model.g.dart';

@freezed
abstract class MessageDetailModel with _$MessageDetailModel {
  const factory MessageDetailModel({
    required String id,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'message_text') required String messageText,
    @JsonKey(name: 'message_type') required String messageType,
    @JsonKey(name: 'reply_to_message_id', defaultValue: null) String? replyToMessageId,
    @JsonKey(name: 'is_edited', defaultValue: false) required bool isEdited,
    @JsonKey(name: 'is_deleted', defaultValue: false) required bool isDeleted,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'read_at') required DateTime? readAt,
    @JsonKey(name: 'sender_name') required String senderName,
    @JsonKey(name: 'sender_surname') required String senderSurname,
    @JsonKey(name: 'sender_nickname') required String senderNickname,
    @JsonKey(name: 'sender_avatar_url') required String? senderAvatarUrl,
  }) = _MessageDetailModel;

  const MessageDetailModel._();

  factory MessageDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailModelFromJson(json);

  MessageEntity toEntity() => MessageEntity(
    id: id,
    chatId: chatId,
    senderId: senderId,
    messageText: messageText,
    messageType: messageType,
    replyToMessageId: replyToMessageId,
    isEdited: isEdited,
    isDeleted: isDeleted,
    createdAt: createdAt,
    readAt: readAt,
    senderName: senderName,
    senderSurname: senderSurname,
    senderNickname: senderNickname,
    senderAvatarUrl: senderAvatarUrl,
  );
}