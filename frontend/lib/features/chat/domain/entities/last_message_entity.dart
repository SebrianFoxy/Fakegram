import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_message_entity.freezed.dart';

@freezed
abstract class LastMessageEntity with _$LastMessageEntity {
  const factory LastMessageEntity({
    required String id,
    required String chatId,
    required String senderId,
    required String messageText,
    required String messageType,
    required bool isEdited,
    required bool isDeleted,
    required DateTime createdAt,
  }) = _LastMessageEntity;

  const LastMessageEntity._();
}