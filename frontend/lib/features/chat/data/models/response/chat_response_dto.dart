import 'package:freezed_annotation/freezed_annotation.dart';
import '../chat/direct_chat_model.dart';


part 'chat_response_dto.freezed.dart';
part 'chat_response_dto.g.dart';

@freezed
abstract class ChatResponseDTO with _$ChatResponseDTO {
  const factory ChatResponseDTO({
    @JsonKey(name: "chats") required List<DirectChatModel> chats,
    @JsonKey(name: "count") required int count,
  }) = _ChatResponseDTO;

  factory ChatResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseDTOFromJson(json);
}
