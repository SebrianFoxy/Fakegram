// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessageState()';
  }
}

/// @nodoc
class $MessageStateCopyWith<$Res> {
  $MessageStateCopyWith(MessageState _, $Res Function(MessageState) __);
}

/// Adds pattern-matching-related methods to [MessageState].
extension MessageStatePatterns on MessageState {
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
    TResult Function(MessageStateInitial value)? initial,
    TResult Function(MessageStateLoading value)? loading,
    TResult Function(MessageStateSuccess value)? success,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial() when initial != null:
        return initial(_that);
      case MessageStateLoading() when loading != null:
        return loading(_that);
      case MessageStateSuccess() when success != null:
        return success(_that);
      case MessageStateError() when error != null:
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
    required TResult Function(MessageStateInitial value) initial,
    required TResult Function(MessageStateLoading value) loading,
    required TResult Function(MessageStateSuccess value) success,
    required TResult Function(MessageStateError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial():
        return initial(_that);
      case MessageStateLoading():
        return loading(_that);
      case MessageStateSuccess():
        return success(_that);
      case MessageStateError():
        return error(_that);
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
    TResult? Function(MessageStateInitial value)? initial,
    TResult? Function(MessageStateLoading value)? loading,
    TResult? Function(MessageStateSuccess value)? success,
    TResult? Function(MessageStateError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial() when initial != null:
        return initial(_that);
      case MessageStateLoading() when loading != null:
        return loading(_that);
      case MessageStateSuccess() when success != null:
        return success(_that);
      case MessageStateError() when error != null:
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
    TResult Function()? loading,
    TResult Function(
            List<MessageEntity> messages,
            bool hasMoreOlder,
            bool hasMoreNewer,
            bool isLoadingMore,
            bool isLoadingNewer,
            MessageEntity? replyingToMessage,
            String? jumpToMessageId,
            String? olderCursor,
            String? newerCursor,
            int? totalUnread,
            int? firstUnreadIndex,
            String? error)?
        success,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial() when initial != null:
        return initial();
      case MessageStateLoading() when loading != null:
        return loading();
      case MessageStateSuccess() when success != null:
        return success(
            _that.messages,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.isLoadingMore,
            _that.isLoadingNewer,
            _that.replyingToMessage,
            _that.jumpToMessageId,
            _that.olderCursor,
            _that.newerCursor,
            _that.totalUnread,
            _that.firstUnreadIndex,
            _that.error);
      case MessageStateError() when error != null:
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
    required TResult Function() loading,
    required TResult Function(
            List<MessageEntity> messages,
            bool hasMoreOlder,
            bool hasMoreNewer,
            bool isLoadingMore,
            bool isLoadingNewer,
            MessageEntity? replyingToMessage,
            String? jumpToMessageId,
            String? olderCursor,
            String? newerCursor,
            int? totalUnread,
            int? firstUnreadIndex,
            String? error)
        success,
    required TResult Function(Object error) error,
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial():
        return initial();
      case MessageStateLoading():
        return loading();
      case MessageStateSuccess():
        return success(
            _that.messages,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.isLoadingMore,
            _that.isLoadingNewer,
            _that.replyingToMessage,
            _that.jumpToMessageId,
            _that.olderCursor,
            _that.newerCursor,
            _that.totalUnread,
            _that.firstUnreadIndex,
            _that.error);
      case MessageStateError():
        return error(_that.error);
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
    TResult? Function()? loading,
    TResult? Function(
            List<MessageEntity> messages,
            bool hasMoreOlder,
            bool hasMoreNewer,
            bool isLoadingMore,
            bool isLoadingNewer,
            MessageEntity? replyingToMessage,
            String? jumpToMessageId,
            String? olderCursor,
            String? newerCursor,
            int? totalUnread,
            int? firstUnreadIndex,
            String? error)?
        success,
    TResult? Function(Object error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case MessageStateInitial() when initial != null:
        return initial();
      case MessageStateLoading() when loading != null:
        return loading();
      case MessageStateSuccess() when success != null:
        return success(
            _that.messages,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.isLoadingMore,
            _that.isLoadingNewer,
            _that.replyingToMessage,
            _that.jumpToMessageId,
            _that.olderCursor,
            _that.newerCursor,
            _that.totalUnread,
            _that.firstUnreadIndex,
            _that.error);
      case MessageStateError() when error != null:
        return error(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MessageStateInitial implements MessageState {
  const MessageStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessageState.initial()';
  }
}

/// @nodoc

class MessageStateLoading implements MessageState {
  const MessageStateLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessageState.loading()';
  }
}

/// @nodoc

class MessageStateSuccess implements MessageState {
  const MessageStateSuccess(
      {required final List<MessageEntity> messages,
      required this.hasMoreOlder,
      required this.hasMoreNewer,
      required this.isLoadingMore,
      required this.isLoadingNewer,
      this.replyingToMessage,
      this.jumpToMessageId,
      this.olderCursor,
      this.newerCursor,
      this.totalUnread,
      this.firstUnreadIndex,
      this.error})
      : _messages = messages;

  final List<MessageEntity> _messages;
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final bool hasMoreOlder;
  final bool hasMoreNewer;
  final bool isLoadingMore;
  final bool isLoadingNewer;
  final MessageEntity? replyingToMessage;
  final String? jumpToMessageId;
  final String? olderCursor;
  final String? newerCursor;
  final int? totalUnread;
  final int? firstUnreadIndex;
  final String? error;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStateSuccessCopyWith<MessageStateSuccess> get copyWith =>
      _$MessageStateSuccessCopyWithImpl<MessageStateSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageStateSuccess &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.hasMoreOlder, hasMoreOlder) ||
                other.hasMoreOlder == hasMoreOlder) &&
            (identical(other.hasMoreNewer, hasMoreNewer) ||
                other.hasMoreNewer == hasMoreNewer) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isLoadingNewer, isLoadingNewer) ||
                other.isLoadingNewer == isLoadingNewer) &&
            (identical(other.replyingToMessage, replyingToMessage) ||
                other.replyingToMessage == replyingToMessage) &&
            (identical(other.jumpToMessageId, jumpToMessageId) ||
                other.jumpToMessageId == jumpToMessageId) &&
            (identical(other.olderCursor, olderCursor) ||
                other.olderCursor == olderCursor) &&
            (identical(other.newerCursor, newerCursor) ||
                other.newerCursor == newerCursor) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.firstUnreadIndex, firstUnreadIndex) ||
                other.firstUnreadIndex == firstUnreadIndex) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      hasMoreOlder,
      hasMoreNewer,
      isLoadingMore,
      isLoadingNewer,
      replyingToMessage,
      jumpToMessageId,
      olderCursor,
      newerCursor,
      totalUnread,
      firstUnreadIndex,
      error);

  @override
  String toString() {
    return 'MessageState.success(messages: $messages, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, isLoadingMore: $isLoadingMore, isLoadingNewer: $isLoadingNewer, replyingToMessage: $replyingToMessage, jumpToMessageId: $jumpToMessageId, olderCursor: $olderCursor, newerCursor: $newerCursor, totalUnread: $totalUnread, firstUnreadIndex: $firstUnreadIndex, error: $error)';
  }
}

/// @nodoc
abstract mixin class $MessageStateSuccessCopyWith<$Res>
    implements $MessageStateCopyWith<$Res> {
  factory $MessageStateSuccessCopyWith(
          MessageStateSuccess value, $Res Function(MessageStateSuccess) _then) =
      _$MessageStateSuccessCopyWithImpl;
  @useResult
  $Res call(
      {List<MessageEntity> messages,
      bool hasMoreOlder,
      bool hasMoreNewer,
      bool isLoadingMore,
      bool isLoadingNewer,
      MessageEntity? replyingToMessage,
      String? jumpToMessageId,
      String? olderCursor,
      String? newerCursor,
      int? totalUnread,
      int? firstUnreadIndex,
      String? error});

  $MessageEntityCopyWith<$Res>? get replyingToMessage;
}

/// @nodoc
class _$MessageStateSuccessCopyWithImpl<$Res>
    implements $MessageStateSuccessCopyWith<$Res> {
  _$MessageStateSuccessCopyWithImpl(this._self, this._then);

  final MessageStateSuccess _self;
  final $Res Function(MessageStateSuccess) _then;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? hasMoreOlder = null,
    Object? hasMoreNewer = null,
    Object? isLoadingMore = null,
    Object? isLoadingNewer = null,
    Object? replyingToMessage = freezed,
    Object? jumpToMessageId = freezed,
    Object? olderCursor = freezed,
    Object? newerCursor = freezed,
    Object? totalUnread = freezed,
    Object? firstUnreadIndex = freezed,
    Object? error = freezed,
  }) {
    return _then(MessageStateSuccess(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      hasMoreOlder: null == hasMoreOlder
          ? _self.hasMoreOlder
          : hasMoreOlder // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreNewer: null == hasMoreNewer
          ? _self.hasMoreNewer
          : hasMoreNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingNewer: null == isLoadingNewer
          ? _self.isLoadingNewer
          : isLoadingNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      replyingToMessage: freezed == replyingToMessage
          ? _self.replyingToMessage
          : replyingToMessage // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      jumpToMessageId: freezed == jumpToMessageId
          ? _self.jumpToMessageId
          : jumpToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      olderCursor: freezed == olderCursor
          ? _self.olderCursor
          : olderCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      newerCursor: freezed == newerCursor
          ? _self.newerCursor
          : newerCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      totalUnread: freezed == totalUnread
          ? _self.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      firstUnreadIndex: freezed == firstUnreadIndex
          ? _self.firstUnreadIndex
          : firstUnreadIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res>? get replyingToMessage {
    if (_self.replyingToMessage == null) {
      return null;
    }

    return $MessageEntityCopyWith<$Res>(_self.replyingToMessage!, (value) {
      return _then(_self.copyWith(replyingToMessage: value));
    });
  }
}

/// @nodoc

class MessageStateError implements MessageState {
  const MessageStateError({required this.error});

  final Object error;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStateErrorCopyWith<MessageStateError> get copyWith =>
      _$MessageStateErrorCopyWithImpl<MessageStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'MessageState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $MessageStateErrorCopyWith<$Res>
    implements $MessageStateCopyWith<$Res> {
  factory $MessageStateErrorCopyWith(
          MessageStateError value, $Res Function(MessageStateError) _then) =
      _$MessageStateErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$MessageStateErrorCopyWithImpl<$Res>
    implements $MessageStateErrorCopyWith<$Res> {
  _$MessageStateErrorCopyWithImpl(this._self, this._then);

  final MessageStateError _self;
  final $Res Function(MessageStateError) _then;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(MessageStateError(
      error: null == error ? _self.error : error,
    ));
  }
}

// dart format on
