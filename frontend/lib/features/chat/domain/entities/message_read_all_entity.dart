import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_read_all_entity.freezed.dart';
part 'message_read_all_entity.g.dart';

@freezed
abstract class MessageReadAllEntity with _$MessageReadAllEntity {
  const factory MessageReadAllEntity({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'chat_id') required String chatId,
    @JsonKey(name: 'read_at') required DateTime readAt,
  }) = _MessageReadAllEntity;

  factory MessageReadAllEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadAllEntityFromJson(json);
}