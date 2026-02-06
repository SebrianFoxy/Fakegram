import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_response_dto.freezed.dart';
part 'send_message_response_dto.g.dart';

@freezed
abstract class SendMessageResponseDTO with _$SendMessageResponseDTO {
  const factory SendMessageResponseDTO({
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'message') required MessageDetailModel message,
  }) = _SendMessageResponseDTO;

  factory SendMessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseDTOFromJson(json);
}