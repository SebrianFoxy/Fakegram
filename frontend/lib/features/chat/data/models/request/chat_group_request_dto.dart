import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_group_request_dto.freezed.dart';
part 'chat_group_request_dto.g.dart';

@freezed
abstract class ChatGroupRequestDTO with _$ChatGroupRequestDTO {
  const factory ChatGroupRequestDTO({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'member_ids') required List<String> membersIDs,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'description') String? description,
  }) = _ChatGroupRequestDTO;

  factory ChatGroupRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupRequestDTOFromJson(json);
}