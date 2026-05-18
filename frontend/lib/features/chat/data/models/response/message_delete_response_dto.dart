import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_delete_response_dto.freezed.dart';
part 'message_delete_response_dto.g.dart';

@freezed
abstract class MessageDeleteResponseDTO with _$MessageDeleteResponseDTO {
  const factory MessageDeleteResponseDTO({
    @JsonKey(name: "error") String? error,

  }) = _MessageDeleteResponseDTO;

  factory MessageDeleteResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageDeleteResponseDTOFromJson(json);
}