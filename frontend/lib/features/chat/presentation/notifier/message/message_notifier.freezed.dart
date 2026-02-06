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

class MessageStateInitial extends MessageState with DiagnosticableTreeMixin {
  const MessageStateInitial() : super._();

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

class MessageStateSuccessLoading extends MessageState
    with DiagnosticableTreeMixin {
  const MessageStateSuccessLoading(
      {required final List<MessageEntity> messages,
      this.hasMoreMessages = false,
      this.isLoadingMore = false,
      this.error})
      : _messages = messages,
        super._();

  final List<MessageEntity> _messages;
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @JsonKey()
  final bool hasMoreMessages;
  @JsonKey()
  final bool isLoadingMore;
  final String? error;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStateSuccessLoadingCopyWith<MessageStateSuccessLoading>
      get copyWith =>
          _$MessageStateSuccessLoadingCopyWithImpl<MessageStateSuccessLoading>(
              this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'MessageState.successLoading'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('hasMoreMessages', hasMoreMessages))
      ..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageStateSuccessLoading &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.hasMoreMessages, hasMoreMessages) ||
                other.hasMoreMessages == hasMoreMessages) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      hasMoreMessages,
      isLoadingMore,
      error);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.successLoading(messages: $messages, hasMoreMessages: $hasMoreMessages, isLoadingMore: $isLoadingMore, error: $error)';
  }
}

/// @nodoc
abstract mixin class $MessageStateSuccessLoadingCopyWith<$Res>
    implements $MessageStateCopyWith<$Res> {
  factory $MessageStateSuccessLoadingCopyWith(MessageStateSuccessLoading value,
          $Res Function(MessageStateSuccessLoading) _then) =
      _$MessageStateSuccessLoadingCopyWithImpl;
  @useResult
  $Res call(
      {List<MessageEntity> messages,
      bool hasMoreMessages,
      bool isLoadingMore,
      String? error});
}

/// @nodoc
class _$MessageStateSuccessLoadingCopyWithImpl<$Res>
    implements $MessageStateSuccessLoadingCopyWith<$Res> {
  _$MessageStateSuccessLoadingCopyWithImpl(this._self, this._then);

  final MessageStateSuccessLoading _self;
  final $Res Function(MessageStateSuccessLoading) _then;

  /// Create a copy of MessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? hasMoreMessages = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(MessageStateSuccessLoading(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      hasMoreMessages: null == hasMoreMessages
          ? _self.hasMoreMessages
          : hasMoreMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class MessageStateLoading extends MessageState with DiagnosticableTreeMixin {
  const MessageStateLoading() : super._();

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

class MessageStateError extends MessageState with DiagnosticableTreeMixin {
  const MessageStateError({this.error}) : super._();

  final Object? error;

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
  $Res call({Object? error});
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
    Object? error = freezed,
  }) {
    return _then(MessageStateError(
      error: freezed == error ? _self.error : error,
    ));
  }
}

// dart format on
