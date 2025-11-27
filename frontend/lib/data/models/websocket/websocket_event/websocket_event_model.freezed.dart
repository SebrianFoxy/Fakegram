// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketEvent {
  @JsonKey(name: 'type')
  String get event;
  @JsonKey(name: 'payload')
  Map<String, dynamic> get data;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketEventCopyWith<WebSocketEvent> get copyWith =>
      _$WebSocketEventCopyWithImpl<WebSocketEvent>(
          this as WebSocketEvent, _$identity);

  /// Serializes this WebSocketEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketEvent &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'WebSocketEvent(event: $event, data: $data)';
  }
}

/// @nodoc
abstract mixin class $WebSocketEventCopyWith<$Res> {
  factory $WebSocketEventCopyWith(
          WebSocketEvent value, $Res Function(WebSocketEvent) _then) =
      _$WebSocketEventCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String event,
      @JsonKey(name: 'payload') Map<String, dynamic> data});
}

/// @nodoc
class _$WebSocketEventCopyWithImpl<$Res>
    implements $WebSocketEventCopyWith<$Res> {
  _$WebSocketEventCopyWithImpl(this._self, this._then);

  final WebSocketEvent _self;
  final $Res Function(WebSocketEvent) _then;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_self.copyWith(
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebSocketEvent implements WebSocketEvent {
  const _WebSocketEvent(
      {@JsonKey(name: 'type') required this.event,
      @JsonKey(name: 'payload') required final Map<String, dynamic> data})
      : _data = data;
  factory _WebSocketEvent.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String event;
  final Map<String, dynamic> _data;
  @override
  @JsonKey(name: 'payload')
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketEventCopyWith<_WebSocketEvent> get copyWith =>
      __$WebSocketEventCopyWithImpl<_WebSocketEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketEvent &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'WebSocketEvent(event: $event, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketEventCopyWith<$Res>
    implements $WebSocketEventCopyWith<$Res> {
  factory _$WebSocketEventCopyWith(
          _WebSocketEvent value, $Res Function(_WebSocketEvent) _then) =
      __$WebSocketEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String event,
      @JsonKey(name: 'payload') Map<String, dynamic> data});
}

/// @nodoc
class __$WebSocketEventCopyWithImpl<$Res>
    implements _$WebSocketEventCopyWith<$Res> {
  __$WebSocketEventCopyWithImpl(this._self, this._then);

  final _WebSocketEvent _self;
  final $Res Function(_WebSocketEvent) _then;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_WebSocketEvent(
      event: null == event
          ? _self.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$ChatListUpdateEvent {
  ChatResponseDTO get chat;
  String get timestamp;

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatListUpdateEventCopyWith<ChatListUpdateEvent> get copyWith =>
      _$ChatListUpdateEventCopyWithImpl<ChatListUpdateEvent>(
          this as ChatListUpdateEvent, _$identity);

  /// Serializes this ChatListUpdateEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatListUpdateEvent &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat, timestamp);

  @override
  String toString() {
    return 'ChatListUpdateEvent(chat: $chat, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $ChatListUpdateEventCopyWith<$Res> {
  factory $ChatListUpdateEventCopyWith(
          ChatListUpdateEvent value, $Res Function(ChatListUpdateEvent) _then) =
      _$ChatListUpdateEventCopyWithImpl;
  @useResult
  $Res call({ChatResponseDTO chat, String timestamp});

  $ChatResponseDTOCopyWith<$Res> get chat;
}

/// @nodoc
class _$ChatListUpdateEventCopyWithImpl<$Res>
    implements $ChatListUpdateEventCopyWith<$Res> {
  _$ChatListUpdateEventCopyWithImpl(this._self, this._then);

  final ChatListUpdateEvent _self;
  final $Res Function(ChatListUpdateEvent) _then;

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatResponseDTO,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatResponseDTOCopyWith<$Res> get chat {
    return $ChatResponseDTOCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ChatListUpdateEvent implements ChatListUpdateEvent {
  const _ChatListUpdateEvent({required this.chat, required this.timestamp});
  factory _ChatListUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$ChatListUpdateEventFromJson(json);

  @override
  final ChatResponseDTO chat;
  @override
  final String timestamp;

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatListUpdateEventCopyWith<_ChatListUpdateEvent> get copyWith =>
      __$ChatListUpdateEventCopyWithImpl<_ChatListUpdateEvent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatListUpdateEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatListUpdateEvent &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat, timestamp);

  @override
  String toString() {
    return 'ChatListUpdateEvent(chat: $chat, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$ChatListUpdateEventCopyWith<$Res>
    implements $ChatListUpdateEventCopyWith<$Res> {
  factory _$ChatListUpdateEventCopyWith(_ChatListUpdateEvent value,
          $Res Function(_ChatListUpdateEvent) _then) =
      __$ChatListUpdateEventCopyWithImpl;
  @override
  @useResult
  $Res call({ChatResponseDTO chat, String timestamp});

  @override
  $ChatResponseDTOCopyWith<$Res> get chat;
}

/// @nodoc
class __$ChatListUpdateEventCopyWithImpl<$Res>
    implements _$ChatListUpdateEventCopyWith<$Res> {
  __$ChatListUpdateEventCopyWithImpl(this._self, this._then);

  final _ChatListUpdateEvent _self;
  final $Res Function(_ChatListUpdateEvent) _then;

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chat = null,
    Object? timestamp = null,
  }) {
    return _then(_ChatListUpdateEvent(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatResponseDTO,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of ChatListUpdateEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatResponseDTOCopyWith<$Res> get chat {
    return $ChatResponseDTOCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

/// @nodoc
mixin _$NewChatCreatedEvent {
  ChatResponseDTO get chat;
  String get timestamp;

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NewChatCreatedEventCopyWith<NewChatCreatedEvent> get copyWith =>
      _$NewChatCreatedEventCopyWithImpl<NewChatCreatedEvent>(
          this as NewChatCreatedEvent, _$identity);

  /// Serializes this NewChatCreatedEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewChatCreatedEvent &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat, timestamp);

  @override
  String toString() {
    return 'NewChatCreatedEvent(chat: $chat, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $NewChatCreatedEventCopyWith<$Res> {
  factory $NewChatCreatedEventCopyWith(
          NewChatCreatedEvent value, $Res Function(NewChatCreatedEvent) _then) =
      _$NewChatCreatedEventCopyWithImpl;
  @useResult
  $Res call({ChatResponseDTO chat, String timestamp});

  $ChatResponseDTOCopyWith<$Res> get chat;
}

/// @nodoc
class _$NewChatCreatedEventCopyWithImpl<$Res>
    implements $NewChatCreatedEventCopyWith<$Res> {
  _$NewChatCreatedEventCopyWithImpl(this._self, this._then);

  final NewChatCreatedEvent _self;
  final $Res Function(NewChatCreatedEvent) _then;

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatResponseDTO,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatResponseDTOCopyWith<$Res> get chat {
    return $ChatResponseDTOCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _NewChatCreatedEvent implements NewChatCreatedEvent {
  const _NewChatCreatedEvent({required this.chat, required this.timestamp});
  factory _NewChatCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$NewChatCreatedEventFromJson(json);

  @override
  final ChatResponseDTO chat;
  @override
  final String timestamp;

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NewChatCreatedEventCopyWith<_NewChatCreatedEvent> get copyWith =>
      __$NewChatCreatedEventCopyWithImpl<_NewChatCreatedEvent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NewChatCreatedEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NewChatCreatedEvent &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat, timestamp);

  @override
  String toString() {
    return 'NewChatCreatedEvent(chat: $chat, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$NewChatCreatedEventCopyWith<$Res>
    implements $NewChatCreatedEventCopyWith<$Res> {
  factory _$NewChatCreatedEventCopyWith(_NewChatCreatedEvent value,
          $Res Function(_NewChatCreatedEvent) _then) =
      __$NewChatCreatedEventCopyWithImpl;
  @override
  @useResult
  $Res call({ChatResponseDTO chat, String timestamp});

  @override
  $ChatResponseDTOCopyWith<$Res> get chat;
}

/// @nodoc
class __$NewChatCreatedEventCopyWithImpl<$Res>
    implements _$NewChatCreatedEventCopyWith<$Res> {
  __$NewChatCreatedEventCopyWithImpl(this._self, this._then);

  final _NewChatCreatedEvent _self;
  final $Res Function(_NewChatCreatedEvent) _then;

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chat = null,
    Object? timestamp = null,
  }) {
    return _then(_NewChatCreatedEvent(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as ChatResponseDTO,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of NewChatCreatedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatResponseDTOCopyWith<$Res> get chat {
    return $ChatResponseDTOCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

/// @nodoc
mixin _$MessageSentEvent {
  DirectMessageModel get message;

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageSentEventCopyWith<MessageSentEvent> get copyWith =>
      _$MessageSentEventCopyWithImpl<MessageSentEvent>(
          this as MessageSentEvent, _$identity);

  /// Serializes this MessageSentEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageSentEvent &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'MessageSentEvent(message: $message)';
  }
}

/// @nodoc
abstract mixin class $MessageSentEventCopyWith<$Res> {
  factory $MessageSentEventCopyWith(
          MessageSentEvent value, $Res Function(MessageSentEvent) _then) =
      _$MessageSentEventCopyWithImpl;
  @useResult
  $Res call({DirectMessageModel message});

  $DirectMessageModelCopyWith<$Res> get message;
}

/// @nodoc
class _$MessageSentEventCopyWithImpl<$Res>
    implements $MessageSentEventCopyWith<$Res> {
  _$MessageSentEventCopyWithImpl(this._self, this._then);

  final MessageSentEvent _self;
  final $Res Function(MessageSentEvent) _then;

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as DirectMessageModel,
    ));
  }

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectMessageModelCopyWith<$Res> get message {
    return $DirectMessageModelCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _MessageSentEvent implements MessageSentEvent {
  const _MessageSentEvent({required this.message});
  factory _MessageSentEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageSentEventFromJson(json);

  @override
  final DirectMessageModel message;

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageSentEventCopyWith<_MessageSentEvent> get copyWith =>
      __$MessageSentEventCopyWithImpl<_MessageSentEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageSentEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageSentEvent &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'MessageSentEvent(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$MessageSentEventCopyWith<$Res>
    implements $MessageSentEventCopyWith<$Res> {
  factory _$MessageSentEventCopyWith(
          _MessageSentEvent value, $Res Function(_MessageSentEvent) _then) =
      __$MessageSentEventCopyWithImpl;
  @override
  @useResult
  $Res call({DirectMessageModel message});

  @override
  $DirectMessageModelCopyWith<$Res> get message;
}

/// @nodoc
class __$MessageSentEventCopyWithImpl<$Res>
    implements _$MessageSentEventCopyWith<$Res> {
  __$MessageSentEventCopyWithImpl(this._self, this._then);

  final _MessageSentEvent _self;
  final $Res Function(_MessageSentEvent) _then;

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_MessageSentEvent(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as DirectMessageModel,
    ));
  }

  /// Create a copy of MessageSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectMessageModelCopyWith<$Res> get message {
    return $DirectMessageModelCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// @nodoc
mixin _$MessageReadEvent {
  String get userID;
  String get chatID;
  String get readUntilID;
  String get readAt;

  /// Create a copy of MessageReadEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageReadEventCopyWith<MessageReadEvent> get copyWith =>
      _$MessageReadEventCopyWithImpl<MessageReadEvent>(
          this as MessageReadEvent, _$identity);

  /// Serializes this MessageReadEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageReadEvent &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.chatID, chatID) || other.chatID == chatID) &&
            (identical(other.readUntilID, readUntilID) ||
                other.readUntilID == readUntilID) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userID, chatID, readUntilID, readAt);

  @override
  String toString() {
    return 'MessageReadEvent(userID: $userID, chatID: $chatID, readUntilID: $readUntilID, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageReadEventCopyWith<$Res> {
  factory $MessageReadEventCopyWith(
          MessageReadEvent value, $Res Function(MessageReadEvent) _then) =
      _$MessageReadEventCopyWithImpl;
  @useResult
  $Res call({String userID, String chatID, String readUntilID, String readAt});
}

/// @nodoc
class _$MessageReadEventCopyWithImpl<$Res>
    implements $MessageReadEventCopyWith<$Res> {
  _$MessageReadEventCopyWithImpl(this._self, this._then);

  final MessageReadEvent _self;
  final $Res Function(MessageReadEvent) _then;

  /// Create a copy of MessageReadEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? chatID = null,
    Object? readUntilID = null,
    Object? readAt = null,
  }) {
    return _then(_self.copyWith(
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      chatID: null == chatID
          ? _self.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      readUntilID: null == readUntilID
          ? _self.readUntilID
          : readUntilID // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MessageReadEvent implements MessageReadEvent {
  const _MessageReadEvent(
      {required this.userID,
      required this.chatID,
      required this.readUntilID,
      required this.readAt});
  factory _MessageReadEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageReadEventFromJson(json);

  @override
  final String userID;
  @override
  final String chatID;
  @override
  final String readUntilID;
  @override
  final String readAt;

  /// Create a copy of MessageReadEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReadEventCopyWith<_MessageReadEvent> get copyWith =>
      __$MessageReadEventCopyWithImpl<_MessageReadEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageReadEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReadEvent &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.chatID, chatID) || other.chatID == chatID) &&
            (identical(other.readUntilID, readUntilID) ||
                other.readUntilID == readUntilID) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userID, chatID, readUntilID, readAt);

  @override
  String toString() {
    return 'MessageReadEvent(userID: $userID, chatID: $chatID, readUntilID: $readUntilID, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageReadEventCopyWith<$Res>
    implements $MessageReadEventCopyWith<$Res> {
  factory _$MessageReadEventCopyWith(
          _MessageReadEvent value, $Res Function(_MessageReadEvent) _then) =
      __$MessageReadEventCopyWithImpl;
  @override
  @useResult
  $Res call({String userID, String chatID, String readUntilID, String readAt});
}

/// @nodoc
class __$MessageReadEventCopyWithImpl<$Res>
    implements _$MessageReadEventCopyWith<$Res> {
  __$MessageReadEventCopyWithImpl(this._self, this._then);

  final _MessageReadEvent _self;
  final $Res Function(_MessageReadEvent) _then;

  /// Create a copy of MessageReadEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userID = null,
    Object? chatID = null,
    Object? readUntilID = null,
    Object? readAt = null,
  }) {
    return _then(_MessageReadEvent(
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      chatID: null == chatID
          ? _self.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      readUntilID: null == readUntilID
          ? _self.readUntilID
          : readUntilID // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UserTypingEvent {
  String get userID;
  String get chatID;
  bool get typing;
  String get at;

  /// Create a copy of UserTypingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserTypingEventCopyWith<UserTypingEvent> get copyWith =>
      _$UserTypingEventCopyWithImpl<UserTypingEvent>(
          this as UserTypingEvent, _$identity);

  /// Serializes this UserTypingEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserTypingEvent &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.chatID, chatID) || other.chatID == chatID) &&
            (identical(other.typing, typing) || other.typing == typing) &&
            (identical(other.at, at) || other.at == at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userID, chatID, typing, at);

  @override
  String toString() {
    return 'UserTypingEvent(userID: $userID, chatID: $chatID, typing: $typing, at: $at)';
  }
}

/// @nodoc
abstract mixin class $UserTypingEventCopyWith<$Res> {
  factory $UserTypingEventCopyWith(
          UserTypingEvent value, $Res Function(UserTypingEvent) _then) =
      _$UserTypingEventCopyWithImpl;
  @useResult
  $Res call({String userID, String chatID, bool typing, String at});
}

/// @nodoc
class _$UserTypingEventCopyWithImpl<$Res>
    implements $UserTypingEventCopyWith<$Res> {
  _$UserTypingEventCopyWithImpl(this._self, this._then);

  final UserTypingEvent _self;
  final $Res Function(UserTypingEvent) _then;

  /// Create a copy of UserTypingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? chatID = null,
    Object? typing = null,
    Object? at = null,
  }) {
    return _then(_self.copyWith(
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      chatID: null == chatID
          ? _self.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      typing: null == typing
          ? _self.typing
          : typing // ignore: cast_nullable_to_non_nullable
              as bool,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserTypingEvent implements UserTypingEvent {
  const _UserTypingEvent(
      {required this.userID,
      required this.chatID,
      required this.typing,
      required this.at});
  factory _UserTypingEvent.fromJson(Map<String, dynamic> json) =>
      _$UserTypingEventFromJson(json);

  @override
  final String userID;
  @override
  final String chatID;
  @override
  final bool typing;
  @override
  final String at;

  /// Create a copy of UserTypingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserTypingEventCopyWith<_UserTypingEvent> get copyWith =>
      __$UserTypingEventCopyWithImpl<_UserTypingEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserTypingEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserTypingEvent &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.chatID, chatID) || other.chatID == chatID) &&
            (identical(other.typing, typing) || other.typing == typing) &&
            (identical(other.at, at) || other.at == at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userID, chatID, typing, at);

  @override
  String toString() {
    return 'UserTypingEvent(userID: $userID, chatID: $chatID, typing: $typing, at: $at)';
  }
}

/// @nodoc
abstract mixin class _$UserTypingEventCopyWith<$Res>
    implements $UserTypingEventCopyWith<$Res> {
  factory _$UserTypingEventCopyWith(
          _UserTypingEvent value, $Res Function(_UserTypingEvent) _then) =
      __$UserTypingEventCopyWithImpl;
  @override
  @useResult
  $Res call({String userID, String chatID, bool typing, String at});
}

/// @nodoc
class __$UserTypingEventCopyWithImpl<$Res>
    implements _$UserTypingEventCopyWith<$Res> {
  __$UserTypingEventCopyWithImpl(this._self, this._then);

  final _UserTypingEvent _self;
  final $Res Function(_UserTypingEvent) _then;

  /// Create a copy of UserTypingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userID = null,
    Object? chatID = null,
    Object? typing = null,
    Object? at = null,
  }) {
    return _then(_UserTypingEvent(
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      chatID: null == chatID
          ? _self.chatID
          : chatID // ignore: cast_nullable_to_non_nullable
              as String,
      typing: null == typing
          ? _self.typing
          : typing // ignore: cast_nullable_to_non_nullable
              as bool,
      at: null == at
          ? _self.at
          : at // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
