import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_response_dto.freezed.dart';
part 'message_response_dto.g.dart';

@freezed
abstract class MessageResponseDTO with _$MessageResponseDTO {
  const factory MessageResponseDTO({
    @JsonKey(name: 'messages') required List<MessageDetailModel> messages,
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'limit') required int limit,
    @JsonKey(name: 'has_next') required bool hasNext,
    @JsonKey(name: 'has_prev') required bool hasPrev,
  }) = _MessageResponseDTO;

  factory MessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDTOFromJson(json);
}