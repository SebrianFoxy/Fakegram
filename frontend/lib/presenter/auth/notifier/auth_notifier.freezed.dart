// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

/// @nodoc

class AuthStateInitial extends AuthState {
  const AuthStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.initial()';
  }
}

/// @nodoc

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({this.user}) : super._();

  final UserDTO? user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateAuthenticatedCopyWith<AuthStateAuthenticated> get copyWith =>
      _$AuthStateAuthenticatedCopyWithImpl<AuthStateAuthenticated>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthStateAuthenticated &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }
}

/// @nodoc
abstract mixin class $AuthStateAuthenticatedCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $AuthStateAuthenticatedCopyWith(AuthStateAuthenticated value,
          $Res Function(AuthStateAuthenticated) _then) =
      _$AuthStateAuthenticatedCopyWithImpl;
  @useResult
  $Res call({UserDTO? user});

  $UserDTOCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthStateAuthenticatedCopyWithImpl<$Res>
    implements $AuthStateAuthenticatedCopyWith<$Res> {
  _$AuthStateAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthStateAuthenticated _self;
  final $Res Function(AuthStateAuthenticated) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = freezed,
  }) {
    return _then(AuthStateAuthenticated(
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDTO?,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDTOCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserDTOCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
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
