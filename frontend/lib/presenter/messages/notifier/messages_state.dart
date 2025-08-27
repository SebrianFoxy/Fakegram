part of 'messages_notifier.dart';

@freezed
class MessagesState with _$MessagesState {
  const MessagesState._();

  const factory MessagesState.initial() = _MessagesStateInitial;

  const factory MessagesState.successLoading({
    required List<dynamic> messages,
  }) = _MessagesStateSuccessLoading;

  const factory MessagesState.loading() = _MessagesStateLoading;

  const factory MessagesState.error({
    Object? error,
  }) = _MessagesStateError;
}