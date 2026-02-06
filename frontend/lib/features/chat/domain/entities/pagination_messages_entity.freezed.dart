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
  int get total;
  int get page;
  int get limit;
  bool get hasNext;
  bool get hasPrev;

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
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      count,
      total,
      page,
      limit,
      hasNext,
      hasPrev);

  @override
  String toString() {
    return 'PaginationMessagesEntity(messages: $messages, count: $count, total: $total, page: $page, limit: $limit, hasNext: $hasNext, hasPrev: $hasPrev)';
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
      int total,
      int page,
      int limit,
      bool hasNext,
      bool hasPrev});
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
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? hasNext = null,
    Object? hasPrev = null,
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
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrev: null == hasPrev
          ? _self.hasPrev
          : hasPrev // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _PaginationMessagesEntity extends PaginationMessagesEntity {
  const _PaginationMessagesEntity(
      {required final List<MessageEntity> messages,
      required this.count,
      required this.total,
      required this.page,
      required this.limit,
      required this.hasNext,
      required this.hasPrev})
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
  final int total;
  @override
  final int page;
  @override
  final int limit;
  @override
  final bool hasNext;
  @override
  final bool hasPrev;

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
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      count,
      total,
      page,
      limit,
      hasNext,
      hasPrev);

  @override
  String toString() {
    return 'PaginationMessagesEntity(messages: $messages, count: $count, total: $total, page: $page, limit: $limit, hasNext: $hasNext, hasPrev: $hasPrev)';
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
      int total,
      int page,
      int limit,
      bool hasNext,
      bool hasPrev});
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
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? hasNext = null,
    Object? hasPrev = null,
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
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrev: null == hasPrev
          ? _self.hasPrev
          : hasPrev // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
