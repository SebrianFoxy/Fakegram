import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_message_response_dto.freezed.dart';
part 'edit_message_response_dto.g.dart';

@freezed
abstract class EditMessageResponseDTO with _$EditMessageResponseDTO {
  const factory EditMessageResponseDTO({
    @JsonKey(name: 'message') required MessageDetailModel message,
  }) = _EditMessageResponseDTO;

  factory EditMessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$EditMessageResponseDTOFromJson(json);
}