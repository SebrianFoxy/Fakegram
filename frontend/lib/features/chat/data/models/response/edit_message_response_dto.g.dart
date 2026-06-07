// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EditMessageResponseDTO _$EditMessageResponseDTOFromJson(
        Map<String, dynamic> json) =>
    _EditMessageResponseDTO(
      message:
          MessageDetailModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditMessageResponseDTOToJson(
        _EditMessageResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
