import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_read_entity.freezed.dart';
part 'message_read_entity.g.dart';

@freezed
abstract class MessageReadEntity with _$MessageReadEntity {
  const factory MessageReadEntity({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'last_read_message_id') required String lastReadMessageId,
    @JsonKey(name: 'read_at') required DateTime readAt,
  }) = _MessageReadEntity;

  factory MessageReadEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadEntityFromJson(json);
}