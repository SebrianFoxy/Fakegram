import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/last_message_entity.dart';

part 'last_message_model.freezed.dart';
part 'last_message_model.g.dart';

@freezed
abstract class LastMessageModel with _$LastMessageModel {
  const factory LastMessageModel({
    required String id,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'message_text') required String messageText,
    @JsonKey(name: 'message_type') required String messageType,
    @JsonKey(name: 'is_edited') required bool isEdited,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LastMessageModel;

  const LastMessageModel._();

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  LastMessageEntity toEntity() => LastMessageEntity(
    id: id,
    chatId: chatId,
    senderId: senderId,
    messageText: messageText,
    messageType: messageType,
    isEdited: isEdited,
    isDeleted: isDeleted,
    createdAt: createdAt,
  );
}