part of 'auth_notifier.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = _AuthStateInitial;

  const factory AuthState.successLoading({
    required List<dynamic> messages,
  }) = _AuthStateSuccessLoading;

  const factory AuthState.loading() = _AuthStateLoading;

  const factory AuthState.error({
    Object? error,
  }) = _AuthStateError;
}