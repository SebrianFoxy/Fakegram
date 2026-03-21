import 'package:freezed_annotation/freezed_annotation.dart';
import 'message_entity.dart';

part 'pagination_messages_entity.freezed.dart';

@freezed
abstract class PaginationMessagesEntity with _$PaginationMessagesEntity {
  const factory PaginationMessagesEntity({
    required List<MessageEntity> messages,
    required int count,
    required int totalUnread,
    required bool hasMoreOlder,
    required bool hasMoreNewer,
    DateTime? firstMsgTime,
    DateTime? lastMsgTime,
    String? olderCursor,
    String? newerCursor,
  }) = _PaginationMessagesEntity;

  const PaginationMessagesEntity._();
}