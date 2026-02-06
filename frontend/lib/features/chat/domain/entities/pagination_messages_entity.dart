import 'package:freezed_annotation/freezed_annotation.dart';
import 'message_entity.dart';

part 'pagination_messages_entity.freezed.dart';

@freezed
abstract class PaginationMessagesEntity with _$PaginationMessagesEntity {
  const factory PaginationMessagesEntity({
    required List<MessageEntity> messages,
    required int count,
    required int total,
    required int page,
    required int limit,
    required bool hasNext,
    required bool hasPrev,
  }) = _PaginationMessagesEntity;

  const PaginationMessagesEntity._();
}