// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState()';
  }
}

/// @nodoc
class $AuthStateCopyWith<$Res> {
  $AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}

/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateRegistrationSuccess value)? registrationSuccess,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial() when initial != null:
        return initial(_that);
      case AuthStateAuthenticated() when authenticated != null:
        return authenticated(_that);
      case AuthStateRegistrationSuccess() when registrationSuccess != null:
        return registrationSuccess(_that);
      case AuthStateLoading() when loading != null:
        return loading(_that);
      case AuthStateError() when error != null:
        return error(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateRegistrationSuccess value)
        registrationSuccess,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial():
        return initial(_that);
      case AuthStateAuthenticated():
        return authenticated(_that);
      case AuthStateRegistrationSuccess():
        return registrationSuccess(_that);
      case AuthStateLoading():
        return loading(_that);
      case AuthStateError():
        return error(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateRegistrationSuccess value)? registrationSuccess,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial() when initial != null:
        return initial(_that);
      case AuthStateAuthenticated() when authenticated != null:
        return authenticated(_that);
      case AuthStateRegistrationSuccess() when registrationSuccess != null:
        return registrationSuccess(_that);
      case AuthStateLoading() when loading != null:
        return loading(_that);
      case AuthStateError() when error != null:
        return error(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? error)? initial,
    TResult Function()? authenticated,
    TResult Function()? registrationSuccess,
    TResult Function()? loading,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial() when initial != null:
        return initial(_that.error);
      case AuthStateAuthenticated() when authenticated != null:
        return authenticated();
      case AuthStateRegistrationSuccess() when registrationSuccess != null:
        return registrationSuccess();
      case AuthStateLoading() when loading != null:
        return loading();
      case AuthStateError() when error != null:
        return error(_that.error);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? error) initial,
    required TResult Function() authenticated,
    required TResult Function() registrationSuccess,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial():
        return initial(_that.error);
      case AuthStateAuthenticated():
        return authenticated();
      case AuthStateRegistrationSuccess():
        return registrationSuccess();
      case AuthStateLoading():
        return loading();
      case AuthStateError():
        return error(_that.error);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? error)? initial,
    TResult? Function()? authenticated,
    TResult? Function()? registrationSuccess,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthStateInitial() when initial != null:
        return initial(_that.error);
      case AuthStateAuthenticated() when authenticated != null:
        return authenticated();
      case AuthStateRegistrationSuccess() when registrationSuccess != null:
        return registrationSuccess();
      case AuthStateLoading() when loading != null:
        return loading();
      case AuthStateError() when error != null:
        return error(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthStateInitial extends AuthState {
  const AuthStateInitial({this.error}) : super._();

  final String? error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateInitialCopyWith<AuthStateInitial> get copyWith =>
      _$AuthStateInitialCopyWithImpl<AuthStateInitial>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthStateInitial &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'AuthState.initial(error: $error)';
  }
}

/// @nodoc
abstract mixin class $AuthStateInitialCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $AuthStateInitialCopyWith(
          AuthStateInitial value, $Res Function(AuthStateInitial) _then) =
      _$AuthStateInitialCopyWithImpl;
  @useResult
  $Res call({String? error});
}

/// @nodoc
class _$AuthStateInitialCopyWithImpl<$Res>
    implements $AuthStateInitialCopyWith<$Res> {
  _$AuthStateInitialCopyWithImpl(this._self, this._then);

  final AuthStateInitial _self;
  final $Res Function(AuthStateInitial) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(AuthStateInitial(
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthStateAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.authenticated()';
  }
}

/// @nodoc

class AuthStateRegistrationSuccess extends AuthState {
  const AuthStateRegistrationSuccess() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthStateRegistrationSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.registrationSuccess()';
  }
}

/// @nodoc

class AuthStateLoading extends AuthState {
  const AuthStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.loading()';
  }
}

/// @nodoc

class AuthStateError extends AuthState {
  const AuthStateError({this.error}) : super._();

  final Object? error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateErrorCopyWith<AuthStateError> get copyWith =>
      _$AuthStateErrorCopyWithImpl<AuthStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'AuthState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $AuthStateErrorCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $AuthStateErrorCopyWith(
          AuthStateError value, $Res Function(AuthStateError) _then) =
      _$AuthStateErrorCopyWithImpl;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class _$AuthStateErrorCopyWithImpl<$Res>
    implements $AuthStateErrorCopyWith<$Res> {
  _$AuthStateErrorCopyWithImpl(this._self, this._then);

  final AuthStateError _self;
  final $Res Function(AuthStateError) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(AuthStateError(
      error: freezed == error ? _self.error : error,
    ));
  }
}

// dart format on
