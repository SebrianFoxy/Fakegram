part of 'message_notifier.dart';

@freezed
abstract class MessageState with _$MessageState {
  const MessageState._();

  const factory MessageState.initial() = MessageStateInitial;

  const factory MessageState.successLoading({
    required List<MessageEntity> messages,
    String? error,
  }) = MessageStateSuccessLoading;

  const factory MessageState.loading() = MessageStateLoading;

  const factory MessageState.error({
    Object? error,
  }) = MessageStateError;
}