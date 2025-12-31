// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState()';
  }
}

/// @nodoc
class $ChatStateCopyWith<$Res> {
  $ChatStateCopyWith(ChatState _, $Res Function(ChatState) __);
}

/// @nodoc

class ChatStateInitial extends ChatState {
  const ChatStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.initial()';
  }
}

/// @nodoc

class ChatStateSuccessLoading extends ChatState {
  const ChatStateSuccessLoading(
      {required final List<DirectChatEntity> chats, this.error})
      : _chats = chats,
        super._();

  final List<DirectChatEntity> _chats;
  List<DirectChatEntity> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  final String? error;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatStateSuccessLoadingCopyWith<ChatStateSuccessLoading> get copyWith =>
      _$ChatStateSuccessLoadingCopyWithImpl<ChatStateSuccessLoading>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatStateSuccessLoading &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_chats), error);

  @override
  String toString() {
    return 'ChatState.successLoading(chats: $chats, error: $error)';
  }
}

/// @nodoc
abstract mixin class $ChatStateSuccessLoadingCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatStateSuccessLoadingCopyWith(ChatStateSuccessLoading value,
          $Res Function(ChatStateSuccessLoading) _then) =
      _$ChatStateSuccessLoadingCopyWithImpl;
  @useResult
  $Res call({List<DirectChatEntity> chats, String? error});
}

/// @nodoc
class _$ChatStateSuccessLoadingCopyWithImpl<$Res>
    implements $ChatStateSuccessLoadingCopyWith<$Res> {
  _$ChatStateSuccessLoadingCopyWithImpl(this._self, this._then);

  final ChatStateSuccessLoading _self;
  final $Res Function(ChatStateSuccessLoading) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chats = null,
    Object? error = freezed,
  }) {
    return _then(ChatStateSuccessLoading(
      chats: null == chats
          ? _self._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<DirectChatEntity>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class ChatStateLoading extends ChatState {
  const ChatStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.loading()';
  }
}

// dart format on
