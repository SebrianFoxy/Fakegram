import 'package:freezed_annotation/freezed_annotation.dart';
import '../chat/direct_chat_model.dart';

part 'chat_group_response_dto.freezed.dart';
part 'chat_group_response_dto.g.dart';

@freezed
abstract class ChatGroupResponseDTO with _$ChatGroupResponseDTO {
  const factory ChatGroupResponseDTO({
    @JsonKey(name: 'chat') required DirectChatModel chat,
  }) = _ChatGroupResponseDTO;

  factory ChatGroupResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupResponseDTOFromJson(json);
}