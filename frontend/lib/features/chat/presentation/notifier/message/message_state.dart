part of 'message_notifier.dart';

@freezed
sealed class MessageState with _$MessageState {
  const factory MessageState.initial() = MessageStateInitial;
  const factory MessageState.loading() = MessageStateLoading;
  const factory MessageState.success({
    required List<MessageEntity> messages,
    required bool hasMoreOlder,
    required bool hasMoreNewer,
    required bool isLoadingMore,
    required bool isLoadingNewer,
    MessageEntity? replyingToMessage,
    MessageEntity? editingMessage,
    String? jumpToMessageId,
    String? olderCursor,
    String? newerCursor,
    int? totalUnread,
    int? firstUnreadIndex,
    String? error,
  }) = MessageStateSuccess;
  const factory MessageState.error({required Object error}) = MessageStateError;
}