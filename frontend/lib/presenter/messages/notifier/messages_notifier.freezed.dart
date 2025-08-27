// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessagesState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MessagesState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessagesState()';
  }
}

/// @nodoc
class $MessagesStateCopyWith<$Res> {
  $MessagesStateCopyWith(MessagesState _, $Res Function(MessagesState) __);
}

/// @nodoc

class _MessagesStateInitial extends MessagesState {
  const _MessagesStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MessagesStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessagesState.initial()';
  }
}

/// @nodoc

class _MessagesStateSuccessLoading extends MessagesState {
  const _MessagesStateSuccessLoading({required final List<dynamic> messages})
      : _messages = messages,
        super._();

  final List<dynamic> _messages;
  List<dynamic> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessagesStateSuccessLoadingCopyWith<_MessagesStateSuccessLoading>
      get copyWith => __$MessagesStateSuccessLoadingCopyWithImpl<
          _MessagesStateSuccessLoading>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessagesStateSuccessLoading &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @override
  String toString() {
    return 'MessagesState.successLoading(messages: $messages)';
  }
}

/// @nodoc
abstract mixin class _$MessagesStateSuccessLoadingCopyWith<$Res>
    implements $MessagesStateCopyWith<$Res> {
  factory _$MessagesStateSuccessLoadingCopyWith(
          _MessagesStateSuccessLoading value,
          $Res Function(_MessagesStateSuccessLoading) _then) =
      __$MessagesStateSuccessLoadingCopyWithImpl;
  @useResult
  $Res call({List<dynamic> messages});
}

/// @nodoc
class __$MessagesStateSuccessLoadingCopyWithImpl<$Res>
    implements _$MessagesStateSuccessLoadingCopyWith<$Res> {
  __$MessagesStateSuccessLoadingCopyWithImpl(this._self, this._then);

  final _MessagesStateSuccessLoading _self;
  final $Res Function(_MessagesStateSuccessLoading) _then;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
  }) {
    return _then(_MessagesStateSuccessLoading(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _MessagesStateLoading extends MessagesState {
  const _MessagesStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MessagesStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MessagesState.loading()';
  }
}

/// @nodoc

class _MessagesStateError extends MessagesState {
  const _MessagesStateError({this.error}) : super._();

  final Object? error;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessagesStateErrorCopyWith<_MessagesStateError> get copyWith =>
      __$MessagesStateErrorCopyWithImpl<_MessagesStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessagesStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'MessagesState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class _$MessagesStateErrorCopyWith<$Res>
    implements $MessagesStateCopyWith<$Res> {
  factory _$MessagesStateErrorCopyWith(
          _MessagesStateError value, $Res Function(_MessagesStateError) _then) =
      __$MessagesStateErrorCopyWithImpl;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$MessagesStateErrorCopyWithImpl<$Res>
    implements _$MessagesStateErrorCopyWith<$Res> {
  __$MessagesStateErrorCopyWithImpl(this._self, this._then);

  final _MessagesStateError _self;
  final $Res Function(_MessagesStateError) _then;

  /// Create a copy of MessagesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_MessagesStateError(
      error: freezed == error ? _self.error : error,
    ));
  }
}

// dart format on
