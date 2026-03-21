import 'package:fakegram/features/chat/data/models/message/message_cursor_model.dart';
import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_response_dto.freezed.dart';
part 'message_response_dto.g.dart';

@freezed
abstract class MessageResponseDTO with _$MessageResponseDTO {
  const factory MessageResponseDTO({
    @JsonKey(name: 'messages') required List<MessageDetailModel> messages,
    @JsonKey(name: 'count') required int count,
    @JsonKey(name: 'total_unread') required int totalUnread,
    @JsonKey(name: 'has_more_older') required bool hasMoreOlder,
    @JsonKey(name: 'has_more_newer') required bool hasMoreNewer,
    @JsonKey(name: 'first_msg_time') String? firstMsgTime,
    @JsonKey(name: 'last_msg_time') String? lastMsgTime,
    @JsonKey(name: 'cursors') MessageCursorsModel? cursors,
  }) = _MessageResponseDTO;

  factory MessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDTOFromJson(json);
}
