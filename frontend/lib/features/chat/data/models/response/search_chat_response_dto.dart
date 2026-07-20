import 'package:freezed_annotation/freezed_annotation.dart';
import '../chat/direct_chat_model.dart';

part 'search_chat_response_dto.freezed.dart';
part 'search_chat_response_dto.g.dart';

@freezed
abstract class SearchChatResponseDTO with _$SearchChatResponseDTO {
  const factory SearchChatResponseDTO({
    @JsonKey(name: "chats") required List<DirectChatModel> chats,
    @JsonKey(name: "count") required int count,
    @JsonKey(name: "query") required String query,
  }) = _SearchChatResponseDTO;

  factory SearchChatResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchChatResponseDTOFromJson(json);
}