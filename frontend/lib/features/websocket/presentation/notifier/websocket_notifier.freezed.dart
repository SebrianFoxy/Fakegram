// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketState implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'WebSocketState'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WebSocketState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState()';
  }
}

/// @nodoc
class $WebSocketStateCopyWith<$Res> {
  $WebSocketStateCopyWith(WebSocketState _, $Res Function(WebSocketState) __);
}

/// Adds pattern-matching-related methods to [WebSocketState].
extension WebSocketStatePatterns on WebSocketState {
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
    TResult Function(_Disconnected value)? disconnected,
    TResult Function(_Connecting value)? connecting,
    TResult Function(_Connected value)? connected,
    TResult Function(_Disconnecting value)? disconnecting,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected() when disconnected != null:
        return disconnected(_that);
      case _Connecting() when connecting != null:
        return connecting(_that);
      case _Connected() when connected != null:
        return connected(_that);
      case _Disconnecting() when disconnecting != null:
        return disconnecting(_that);
      case _Error() when error != null:
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
    required TResult Function(_Disconnected value) disconnected,
    required TResult Function(_Connecting value) connecting,
    required TResult Function(_Connected value) connected,
    required TResult Function(_Disconnecting value) disconnecting,
    required TResult Function(_Error value) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected():
        return disconnected(_that);
      case _Connecting():
        return connecting(_that);
      case _Connected():
        return connected(_that);
      case _Disconnecting():
        return disconnecting(_that);
      case _Error():
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
    TResult? Function(_Disconnected value)? disconnected,
    TResult? Function(_Connecting value)? connecting,
    TResult? Function(_Connected value)? connected,
    TResult? Function(_Disconnecting value)? disconnecting,
    TResult? Function(_Error value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected() when disconnected != null:
        return disconnected(_that);
      case _Connecting() when connecting != null:
        return connecting(_that);
      case _Connected() when connected != null:
        return connected(_that);
      case _Disconnecting() when disconnecting != null:
        return disconnecting(_that);
      case _Error() when error != null:
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
    TResult Function()? disconnected,
    TResult Function()? connecting,
    TResult Function(DateTime? lastConnected)? connected,
    TResult Function()? disconnecting,
    TResult Function(String error, DateTime? lastError)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected() when disconnected != null:
        return disconnected();
      case _Connecting() when connecting != null:
        return connecting();
      case _Connected() when connected != null:
        return connected(_that.lastConnected);
      case _Disconnecting() when disconnecting != null:
        return disconnecting();
      case _Error() when error != null:
        return error(_that.error, _that.lastError);
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
    required TResult Function() disconnected,
    required TResult Function() connecting,
    required TResult Function(DateTime? lastConnected) connected,
    required TResult Function() disconnecting,
    required TResult Function(String error, DateTime? lastError) error,
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected():
        return disconnected();
      case _Connecting():
        return connecting();
      case _Connected():
        return connected(_that.lastConnected);
      case _Disconnecting():
        return disconnecting();
      case _Error():
        return error(_that.error, _that.lastError);
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
    TResult? Function()? disconnected,
    TResult? Function()? connecting,
    TResult? Function(DateTime? lastConnected)? connected,
    TResult? Function()? disconnecting,
    TResult? Function(String error, DateTime? lastError)? error,
  }) {
    final _that = this;
    switch (_that) {
      case _Disconnected() when disconnected != null:
        return disconnected();
      case _Connecting() when connecting != null:
        return connecting();
      case _Connected() when connected != null:
        return connected(_that.lastConnected);
      case _Disconnecting() when disconnecting != null:
        return disconnecting();
      case _Error() when error != null:
        return error(_that.error, _that.lastError);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Disconnected with DiagnosticableTreeMixin implements WebSocketState {
  const _Disconnected();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'WebSocketState.disconnected'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Disconnected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState.disconnected()';
  }
}

/// @nodoc

class _Connecting with DiagnosticableTreeMixin implements WebSocketState {
  const _Connecting();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'WebSocketState.connecting'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Connecting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState.connecting()';
  }
}

/// @nodoc

class _Connected with DiagnosticableTreeMixin implements WebSocketState {
  const _Connected({this.lastConnected});

  final DateTime? lastConnected;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectedCopyWith<_Connected> get copyWith =>
      __$ConnectedCopyWithImpl<_Connected>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'WebSocketState.connected'))
      ..add(DiagnosticsProperty('lastConnected', lastConnected));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Connected &&
            (identical(other.lastConnected, lastConnected) ||
                other.lastConnected == lastConnected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastConnected);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState.connected(lastConnected: $lastConnected)';
  }
}

/// @nodoc
abstract mixin class _$ConnectedCopyWith<$Res>
    implements $WebSocketStateCopyWith<$Res> {
  factory _$ConnectedCopyWith(
          _Connected value, $Res Function(_Connected) _then) =
      __$ConnectedCopyWithImpl;
  @useResult
  $Res call({DateTime? lastConnected});
}

/// @nodoc
class __$ConnectedCopyWithImpl<$Res> implements _$ConnectedCopyWith<$Res> {
  __$ConnectedCopyWithImpl(this._self, this._then);

  final _Connected _self;
  final $Res Function(_Connected) _then;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastConnected = freezed,
  }) {
    return _then(_Connected(
      lastConnected: freezed == lastConnected
          ? _self.lastConnected
          : lastConnected // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _Disconnecting with DiagnosticableTreeMixin implements WebSocketState {
  const _Disconnecting();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'WebSocketState.disconnecting'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Disconnecting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState.disconnecting()';
  }
}

/// @nodoc

class _Error with DiagnosticableTreeMixin implements WebSocketState {
  const _Error({required this.error, this.lastError});

  final String error;
  final DateTime? lastError;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'WebSocketState.error'))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('lastError', lastError));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastError, lastError) ||
                other.lastError == lastError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, lastError);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WebSocketState.error(error: $error, lastError: $lastError)';
  }
}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res>
    implements $WebSocketStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) =
      __$ErrorCopyWithImpl;
  @useResult
  $Res call({String error, DateTime? lastError});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
    Object? lastError = freezed,
  }) {
    return _then(_Error(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      lastError: freezed == lastError
          ? _self.lastError
          : lastError // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
