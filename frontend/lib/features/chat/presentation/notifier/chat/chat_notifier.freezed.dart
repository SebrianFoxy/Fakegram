// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState()';
  }
}

/// @nodoc
class $ChatStateCopyWith<$Res> {
  $ChatStateCopyWith(ChatState _, $Res Function(ChatState) __);
}

/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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
    TResult Function(ChatStateInitial value)? initial,
    TResult Function(ChatStateSuccessLoading value)? successLoading,
    TResult Function(ChatStateLoading value)? loading,
    TResult Function(ChatStateError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial() when initial != null:
        return initial(_that);
      case ChatStateSuccessLoading() when successLoading != null:
        return successLoading(_that);
      case ChatStateLoading() when loading != null:
        return loading(_that);
      case ChatStateError() when error != null:
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
    required TResult Function(ChatStateInitial value) initial,
    required TResult Function(ChatStateSuccessLoading value) successLoading,
    required TResult Function(ChatStateLoading value) loading,
    required TResult Function(ChatStateError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial():
        return initial(_that);
      case ChatStateSuccessLoading():
        return successLoading(_that);
      case ChatStateLoading():
        return loading(_that);
      case ChatStateError():
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
    TResult? Function(ChatStateInitial value)? initial,
    TResult? Function(ChatStateSuccessLoading value)? successLoading,
    TResult? Function(ChatStateLoading value)? loading,
    TResult? Function(ChatStateError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial() when initial != null:
        return initial(_that);
      case ChatStateSuccessLoading() when successLoading != null:
        return successLoading(_that);
      case ChatStateLoading() when loading != null:
        return loading(_that);
      case ChatStateError() when error != null:
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
    TResult Function()? initial,
    TResult Function(List<DirectChatEntity> chats, String? error)?
        successLoading,
    TResult Function()? loading,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial() when initial != null:
        return initial();
      case ChatStateSuccessLoading() when successLoading != null:
        return successLoading(_that.chats, _that.error);
      case ChatStateLoading() when loading != null:
        return loading();
      case ChatStateError() when error != null:
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
    required TResult Function() initial,
    required TResult Function(List<DirectChatEntity> chats, String? error)
        successLoading,
    required TResult Function() loading,
    required TResult Function(Object? error) error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial():
        return initial();
      case ChatStateSuccessLoading():
        return successLoading(_that.chats, _that.error);
      case ChatStateLoading():
        return loading();
      case ChatStateError():
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
    TResult? Function()? initial,
    TResult? Function(List<DirectChatEntity> chats, String? error)?
        successLoading,
    TResult? Function()? loading,
    TResult? Function(Object? error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ChatStateInitial() when initial != null:
        return initial();
      case ChatStateSuccessLoading() when successLoading != null:
        return successLoading(_that.chats, _that.error);
      case ChatStateLoading() when loading != null:
        return loading();
      case ChatStateError() when error != null:
        return error(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ChatStateInitial extends ChatState {
  const ChatStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.initial()';
  }
}

/// @nodoc

class ChatStateSuccessLoading extends ChatState {
  const ChatStateSuccessLoading(
      {required final List<DirectChatEntity> chats, this.error})
      : _chats = chats,
        super._();

  final List<DirectChatEntity> _chats;
  List<DirectChatEntity> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  final String? error;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatStateSuccessLoadingCopyWith<ChatStateSuccessLoading> get copyWith =>
      _$ChatStateSuccessLoadingCopyWithImpl<ChatStateSuccessLoading>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatStateSuccessLoading &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_chats), error);

  @override
  String toString() {
    return 'ChatState.successLoading(chats: $chats, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ChatStateSuccessLoadingCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatStateSuccessLoadingCopyWith(ChatStateSuccessLoading value,
          $Res Function(ChatStateSuccessLoading) _then) =
      _$ChatStateSuccessLoadingCopyWithImpl;
  @useResult
  $Res call({List<DirectChatEntity> chats, String? error});
}

/// @nodoc
class _$ChatStateSuccessLoadingCopyWithImpl<$Res>
    implements $ChatStateSuccessLoadingCopyWith<$Res> {
  _$ChatStateSuccessLoadingCopyWithImpl(this._self, this._then);

  final ChatStateSuccessLoading _self;
  final $Res Function(ChatStateSuccessLoading) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chats = null,
    Object? error = freezed,
  }) {
    return _then(ChatStateSuccessLoading(
      chats: null == chats
          ? _self._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<DirectChatEntity>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class ChatStateLoading extends ChatState {
  const ChatStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.loading()';
  }
}

/// @nodoc

class ChatStateError extends ChatState {
  const ChatStateError({this.error}) : super._();

  final Object? error;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatStateErrorCopyWith<ChatStateError> get copyWith =>
      _$ChatStateErrorCopyWithImpl<ChatStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'ChatState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ChatStateErrorCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatStateErrorCopyWith(
          ChatStateError value, $Res Function(ChatStateError) _then) =
      _$ChatStateErrorCopyWithImpl;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class _$ChatStateErrorCopyWithImpl<$Res>
    implements $ChatStateErrorCopyWith<$Res> {
  _$ChatStateErrorCopyWithImpl(this._self, this._then);

  final ChatStateError _self;
  final $Res Function(ChatStateError) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(ChatStateError(
      error: freezed == error ? _self.error : error,
    ));
  }
}

// dart format on
