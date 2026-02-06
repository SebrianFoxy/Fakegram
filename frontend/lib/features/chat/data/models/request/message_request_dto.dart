import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_request_dto.freezed.dart';
part 'message_request_dto.g.dart';

@freezed
abstract class MessageRequestDTO with _$MessageRequestDTO {
  const factory MessageRequestDTO({
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'message_text') required String message,
    @JsonKey(name: 'message_type') required String messageType,
    @JsonKey(name: 'receiver_id') String? receiverId,
    @JsonKey(name: 'reply_to_message_id', defaultValue: '') required String replyToMessageId,
  }) = _MessageRequestDTO;

  factory MessageRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestDTOFromJson(json);
}