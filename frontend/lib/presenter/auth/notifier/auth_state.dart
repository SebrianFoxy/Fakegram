part of 'auth_notifier.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial({
    String? error
  }) = AuthStateInitial;

  const factory AuthState.authenticated() = AuthStateAuthenticated;

  const factory AuthState.registrationSuccess() = AuthStateRegistrationSuccess;

  const factory AuthState.loading() = AuthStateLoading;

  const factory AuthState.error({
    Object? error,
  }) = AuthStateError;

  bool get isAuthenticated => this is AuthStateAuthenticated;
}