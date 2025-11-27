// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketMessage {
  String get type;
  Map<String, dynamic> get payload;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketMessageCopyWith<WebSocketMessage> get copyWith =>
      _$WebSocketMessageCopyWithImpl<WebSocketMessage>(
          this as WebSocketMessage, _$identity);

  /// Serializes this WebSocketMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketMessage &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(payload));

  @override
  String toString() {
    return 'WebSocketMessage(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $WebSocketMessageCopyWith<$Res> {
  factory $WebSocketMessageCopyWith(
          WebSocketMessage value, $Res Function(WebSocketMessage) _then) =
      _$WebSocketMessageCopyWithImpl;
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class _$WebSocketMessageCopyWithImpl<$Res>
    implements $WebSocketMessageCopyWith<$Res> {
  _$WebSocketMessageCopyWithImpl(this._self, this._then);

  final WebSocketMessage _self;
  final $Res Function(WebSocketMessage) _then;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebSocketMessage implements WebSocketMessage {
  const _WebSocketMessage(
      {required this.type, required final Map<String, dynamic> payload})
      : _payload = payload;
  factory _WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketMessageCopyWith<_WebSocketMessage> get copyWith =>
      __$WebSocketMessageCopyWithImpl<_WebSocketMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketMessage &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_payload));

  @override
  String toString() {
    return 'WebSocketMessage(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketMessageCopyWith<$Res>
    implements $WebSocketMessageCopyWith<$Res> {
  factory _$WebSocketMessageCopyWith(
          _WebSocketMessage value, $Res Function(_WebSocketMessage) _then) =
      __$WebSocketMessageCopyWithImpl;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class __$WebSocketMessageCopyWithImpl<$Res>
    implements _$WebSocketMessageCopyWith<$Res> {
  __$WebSocketMessageCopyWithImpl(this._self, this._then);

  final _WebSocketMessage _self;
  final $Res Function(_WebSocketMessage) _then;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_WebSocketMessage(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
