// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketEventEntity {
  String get event;
  Map<String, dynamic> get data;

  /// Create a copy of WebSocketEventEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketEventEntityCopyWith<WebSocketEventEntity> get copyWith =>
      _$WebSocketEventEntityCopyWithImpl<WebSocketEventEntity>(
          this as WebSocketEventEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketEventEntity &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'WebSocketEventEntity(event: $event, data: $data)';
  }
}

/// @nodoc
abstract mixin class $WebSocketEventEntityCopyWith<$Res> {
  factory $WebSocketEventEntityCopyWith(WebSocketEventEntity value,
          $Res Function(WebSocketEventEntity) _then) =
      _$WebSocketEventEntityCopyWithImpl;
  @useResult
  $Res call({String event, Map<String, dynamic> data});
}

/// @nodoc
class _$WebSocketEventEntityCopyWithImpl<$Res>
    implements $WebSocketEventEntityCopyWith<$Res> {
  _$WebSocketEventEntityCopyWithImpl(this._self, this._then);

  final WebSocketEventEntity _self;
  final $Res Function(WebSocketEventEntity) _then;

  /// Create a copy of WebSocketEventEntity
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

class _WebSocketEventEntity extends WebSocketEventEntity {
  const _WebSocketEventEntity(
      {required this.event, required final Map<String, dynamic> data})
      : _data = data,
        super._();

  @override
  final String event;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// Create a copy of WebSocketEventEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketEventEntityCopyWith<_WebSocketEventEntity> get copyWith =>
      __$WebSocketEventEntityCopyWithImpl<_WebSocketEventEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketEventEntity &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'WebSocketEventEntity(event: $event, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketEventEntityCopyWith<$Res>
    implements $WebSocketEventEntityCopyWith<$Res> {
  factory _$WebSocketEventEntityCopyWith(_WebSocketEventEntity value,
          $Res Function(_WebSocketEventEntity) _then) =
      __$WebSocketEventEntityCopyWithImpl;
  @override
  @useResult
  $Res call({String event, Map<String, dynamic> data});
}

/// @nodoc
class __$WebSocketEventEntityCopyWithImpl<$Res>
    implements _$WebSocketEventEntityCopyWith<$Res> {
  __$WebSocketEventEntityCopyWithImpl(this._self, this._then);

  final _WebSocketEventEntity _self;
  final $Res Function(_WebSocketEventEntity) _then;

  /// Create a copy of WebSocketEventEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_WebSocketEventEntity(
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

// dart format on
