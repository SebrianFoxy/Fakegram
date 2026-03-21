// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageState implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'MessageState'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState()';
  }
}

/// @nodoc
class $MessageStateCopyWith<$Res> {
  $MessageStateCopyWith(MessageState _, $Res Function(MessageState) __);
}

/// @nodoc

class MessageStateInitial with DiagnosticableTreeMixin implements MessageState {
  const MessageStateInitial();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'MessageState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.initial()';
  }
}

/// @nodoc

class MessageStateLoading with DiagnosticableTreeMixin implements MessageState {
  const MessageStateLoading();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'MessageState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessageStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.loading()';
  }
}

/// @nodoc

class MessageStateSuccess with DiagnosticableTreeMixin implements MessageState {
  const MessageStateSuccess(
      {required final List<MessageEntity> messages,
      required this.hasMoreOlder,
      required this.hasMoreNewer,
      required this.isLoadingMore,
      required this.isLoadingNewer,
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MessageState.success'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('hasMoreOlder', hasMoreOlder))
      ..add(DiagnosticsProperty('hasMoreNewer', hasMoreNewer))
      ..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))
      ..add(DiagnosticsProperty('isLoadingNewer', isLoadingNewer))
      ..add(DiagnosticsProperty('olderCursor', olderCursor))
      ..add(DiagnosticsProperty('newerCursor', newerCursor))
      ..add(DiagnosticsProperty('totalUnread', totalUnread))
      ..add(DiagnosticsProperty('firstUnreadIndex', firstUnreadIndex))
      ..add(DiagnosticsProperty('error', error));
  }

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
      olderCursor,
      newerCursor,
      totalUnread,
      firstUnreadIndex,
      error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.success(messages: $messages, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, isLoadingMore: $isLoadingMore, isLoadingNewer: $isLoadingNewer, olderCursor: $olderCursor, newerCursor: $newerCursor, totalUnread: $totalUnread, firstUnreadIndex: $firstUnreadIndex, error: $error)';
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
      String? olderCursor,
      String? newerCursor,
      int? totalUnread,
      int? firstUnreadIndex,
      String? error});
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
}

/// @nodoc

class MessageStateError with DiagnosticableTreeMixin implements MessageState {
  const MessageStateError({required this.error});

  final Object error;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStateErrorCopyWith<MessageStateError> get copyWith =>
      _$MessageStateErrorCopyWithImpl<MessageStateError>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MessageState.error'))
      ..add(DiagnosticsProperty('error', error));
  }

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
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
