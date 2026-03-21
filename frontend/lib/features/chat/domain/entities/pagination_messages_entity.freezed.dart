// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_messages_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationMessagesEntity {
  List<MessageEntity> get messages;
  int get count;
  int get totalUnread;
  bool get hasMoreOlder;
  bool get hasMoreNewer;
  DateTime? get firstMsgTime;
  DateTime? get lastMsgTime;
  String? get olderCursor;
  String? get newerCursor;

  /// Create a copy of PaginationMessagesEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationMessagesEntityCopyWith<PaginationMessagesEntity> get copyWith =>
      _$PaginationMessagesEntityCopyWithImpl<PaginationMessagesEntity>(
          this as PaginationMessagesEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginationMessagesEntity &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.hasMoreOlder, hasMoreOlder) ||
                other.hasMoreOlder == hasMoreOlder) &&
            (identical(other.hasMoreNewer, hasMoreNewer) ||
                other.hasMoreNewer == hasMoreNewer) &&
            (identical(other.firstMsgTime, firstMsgTime) ||
                other.firstMsgTime == firstMsgTime) &&
            (identical(other.lastMsgTime, lastMsgTime) ||
                other.lastMsgTime == lastMsgTime) &&
            (identical(other.olderCursor, olderCursor) ||
                other.olderCursor == olderCursor) &&
            (identical(other.newerCursor, newerCursor) ||
                other.newerCursor == newerCursor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      count,
      totalUnread,
      hasMoreOlder,
      hasMoreNewer,
      firstMsgTime,
      lastMsgTime,
      olderCursor,
      newerCursor);

  @override
  String toString() {
    return 'PaginationMessagesEntity(messages: $messages, count: $count, totalUnread: $totalUnread, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, firstMsgTime: $firstMsgTime, lastMsgTime: $lastMsgTime, olderCursor: $olderCursor, newerCursor: $newerCursor)';
  }
}

/// @nodoc
abstract mixin class $PaginationMessagesEntityCopyWith<$Res> {
  factory $PaginationMessagesEntityCopyWith(PaginationMessagesEntity value,
          $Res Function(PaginationMessagesEntity) _then) =
      _$PaginationMessagesEntityCopyWithImpl;
  @useResult
  $Res call(
      {List<MessageEntity> messages,
      int count,
      int totalUnread,
      bool hasMoreOlder,
      bool hasMoreNewer,
      DateTime? firstMsgTime,
      DateTime? lastMsgTime,
      String? olderCursor,
      String? newerCursor});
}

/// @nodoc
class _$PaginationMessagesEntityCopyWithImpl<$Res>
    implements $PaginationMessagesEntityCopyWith<$Res> {
  _$PaginationMessagesEntityCopyWithImpl(this._self, this._then);

  final PaginationMessagesEntity _self;
  final $Res Function(PaginationMessagesEntity) _then;

  /// Create a copy of PaginationMessagesEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? count = null,
    Object? totalUnread = null,
    Object? hasMoreOlder = null,
    Object? hasMoreNewer = null,
    Object? firstMsgTime = freezed,
    Object? lastMsgTime = freezed,
    Object? olderCursor = freezed,
    Object? newerCursor = freezed,
  }) {
    return _then(_self.copyWith(
      messages: null == messages
          ? _self.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalUnread: null == totalUnread
          ? _self.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreOlder: null == hasMoreOlder
          ? _self.hasMoreOlder
          : hasMoreOlder // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreNewer: null == hasMoreNewer
          ? _self.hasMoreNewer
          : hasMoreNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      firstMsgTime: freezed == firstMsgTime
          ? _self.firstMsgTime
          : firstMsgTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMsgTime: freezed == lastMsgTime
          ? _self.lastMsgTime
          : lastMsgTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      olderCursor: freezed == olderCursor
          ? _self.olderCursor
          : olderCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      newerCursor: freezed == newerCursor
          ? _self.newerCursor
          : newerCursor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _PaginationMessagesEntity extends PaginationMessagesEntity {
  const _PaginationMessagesEntity(
      {required final List<MessageEntity> messages,
      required this.count,
      required this.totalUnread,
      required this.hasMoreOlder,
      required this.hasMoreNewer,
      this.firstMsgTime,
      this.lastMsgTime,
      this.olderCursor,
      this.newerCursor})
      : _messages = messages,
        super._();

  final List<MessageEntity> _messages;
  @override
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final int count;
  @override
  final int totalUnread;
  @override
  final bool hasMoreOlder;
  @override
  final bool hasMoreNewer;
  @override
  final DateTime? firstMsgTime;
  @override
  final DateTime? lastMsgTime;
  @override
  final String? olderCursor;
  @override
  final String? newerCursor;

  /// Create a copy of PaginationMessagesEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationMessagesEntityCopyWith<_PaginationMessagesEntity> get copyWith =>
      __$PaginationMessagesEntityCopyWithImpl<_PaginationMessagesEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationMessagesEntity &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.hasMoreOlder, hasMoreOlder) ||
                other.hasMoreOlder == hasMoreOlder) &&
            (identical(other.hasMoreNewer, hasMoreNewer) ||
                other.hasMoreNewer == hasMoreNewer) &&
            (identical(other.firstMsgTime, firstMsgTime) ||
                other.firstMsgTime == firstMsgTime) &&
            (identical(other.lastMsgTime, lastMsgTime) ||
                other.lastMsgTime == lastMsgTime) &&
            (identical(other.olderCursor, olderCursor) ||
                other.olderCursor == olderCursor) &&
            (identical(other.newerCursor, newerCursor) ||
                other.newerCursor == newerCursor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      count,
      totalUnread,
      hasMoreOlder,
      hasMoreNewer,
      firstMsgTime,
      lastMsgTime,
      olderCursor,
      newerCursor);

  @override
  String toString() {
    return 'PaginationMessagesEntity(messages: $messages, count: $count, totalUnread: $totalUnread, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, firstMsgTime: $firstMsgTime, lastMsgTime: $lastMsgTime, olderCursor: $olderCursor, newerCursor: $newerCursor)';
  }
}

/// @nodoc
abstract mixin class _$PaginationMessagesEntityCopyWith<$Res>
    implements $PaginationMessagesEntityCopyWith<$Res> {
  factory _$PaginationMessagesEntityCopyWith(_PaginationMessagesEntity value,
          $Res Function(_PaginationMessagesEntity) _then) =
      __$PaginationMessagesEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<MessageEntity> messages,
      int count,
      int totalUnread,
      bool hasMoreOlder,
      bool hasMoreNewer,
      DateTime? firstMsgTime,
      DateTime? lastMsgTime,
      String? olderCursor,
      String? newerCursor});
}

/// @nodoc
class __$PaginationMessagesEntityCopyWithImpl<$Res>
    implements _$PaginationMessagesEntityCopyWith<$Res> {
  __$PaginationMessagesEntityCopyWithImpl(this._self, this._then);

  final _PaginationMessagesEntity _self;
  final $Res Function(_PaginationMessagesEntity) _then;

  /// Create a copy of PaginationMessagesEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? count = null,
    Object? totalUnread = null,
    Object? hasMoreOlder = null,
    Object? hasMoreNewer = null,
    Object? firstMsgTime = freezed,
    Object? lastMsgTime = freezed,
    Object? olderCursor = freezed,
    Object? newerCursor = freezed,
  }) {
    return _then(_PaginationMessagesEntity(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalUnread: null == totalUnread
          ? _self.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreOlder: null == hasMoreOlder
          ? _self.hasMoreOlder
          : hasMoreOlder // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreNewer: null == hasMoreNewer
          ? _self.hasMoreNewer
          : hasMoreNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      firstMsgTime: freezed == firstMsgTime
          ? _self.firstMsgTime
          : firstMsgTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMsgTime: freezed == lastMsgTime
          ? _self.lastMsgTime
          : lastMsgTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      olderCursor: freezed == olderCursor
          ? _self.olderCursor
          : olderCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      newerCursor: freezed == newerCursor
          ? _self.newerCursor
          : newerCursor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
