// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageResponseDTO _$MessageResponseDTOFromJson(Map<String, dynamic> json) =>
    _MessageResponseDTO(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
      totalUnread: (json['total_unread'] as num).toInt(),
      hasMoreOlder: json['has_more_older'] as bool,
      hasMoreNewer: json['has_more_newer'] as bool,
      firstMsgTime: json['first_msg_time'] as String?,
      lastMsgTime: json['last_msg_time'] as String?,
      cursors: json['cursors'] == null
          ? null
          : MessageCursorsModel.fromJson(
              json['cursors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageResponseDTOToJson(_MessageResponseDTO instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'count': instance.count,
      'total_unread': instance.totalUnread,
      'has_more_older': instance.hasMoreOlder,
      'has_more_newer': instance.hasMoreNewer,
      'first_msg_time': instance.firstMsgTime,
      'last_msg_time': instance.lastMsgTime,
      'cursors': instance.cursors,
    };
