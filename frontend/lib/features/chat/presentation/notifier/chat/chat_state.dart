part of 'chat_notifier.dart';

@freezed
class ChatState with _$ChatState {
  const ChatState._();

  const factory ChatState.initial() = ChatStateInitial;

  const factory ChatState.successLoading({
    required List<DirectChatEntity> chats,
    String? error,
  }) = ChatStateSuccessLoading;

  const factory ChatState.loading() = ChatStateLoading;

  const factory ChatState.error({
    Object? error,
  }) = ChatStateError;
}