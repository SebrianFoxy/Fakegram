import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_message_entity.freezed.dart';

@freezed
abstract class DirectMessageEntity with _$DirectMessageEntity {
  const DirectMessageEntity._();

  const factory DirectMessageEntity({
    required String id,
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime createdAt,
    @Default(false) bool isRead,
    @Default(false) bool isDelivered,
    @Default(false) bool isDeleted,
  }) = _DirectMessageEntity;
}