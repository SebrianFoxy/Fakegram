// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketMessageEntity {
  String get type;
  Map<String, dynamic> get payload;

  /// Create a copy of WebSocketMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketMessageEntityCopyWith<WebSocketMessageEntity> get copyWith =>
      _$WebSocketMessageEntityCopyWithImpl<WebSocketMessageEntity>(
          this as WebSocketMessageEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketMessageEntity &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(payload));

  @override
  String toString() {
    return 'WebSocketMessageEntity(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $WebSocketMessageEntityCopyWith<$Res> {
  factory $WebSocketMessageEntityCopyWith(WebSocketMessageEntity value,
          $Res Function(WebSocketMessageEntity) _then) =
      _$WebSocketMessageEntityCopyWithImpl;
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class _$WebSocketMessageEntityCopyWithImpl<$Res>
    implements $WebSocketMessageEntityCopyWith<$Res> {
  _$WebSocketMessageEntityCopyWithImpl(this._self, this._then);

  final WebSocketMessageEntity _self;
  final $Res Function(WebSocketMessageEntity) _then;

  /// Create a copy of WebSocketMessageEntity
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

class _WebSocketMessageEntity extends WebSocketMessageEntity {
  const _WebSocketMessageEntity(
      {required this.type, required final Map<String, dynamic> payload})
      : _payload = payload,
        super._();

  @override
  final String type;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  /// Create a copy of WebSocketMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketMessageEntityCopyWith<_WebSocketMessageEntity> get copyWith =>
      __$WebSocketMessageEntityCopyWithImpl<_WebSocketMessageEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketMessageEntity &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_payload));

  @override
  String toString() {
    return 'WebSocketMessageEntity(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketMessageEntityCopyWith<$Res>
    implements $WebSocketMessageEntityCopyWith<$Res> {
  factory _$WebSocketMessageEntityCopyWith(_WebSocketMessageEntity value,
          $Res Function(_WebSocketMessageEntity) _then) =
      __$WebSocketMessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class __$WebSocketMessageEntityCopyWithImpl<$Res>
    implements _$WebSocketMessageEntityCopyWith<$Res> {
  __$WebSocketMessageEntityCopyWithImpl(this._self, this._then);

  final _WebSocketMessageEntity _self;
  final $Res Function(_WebSocketMessageEntity) _then;

  /// Create a copy of WebSocketMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_WebSocketMessageEntity(
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
