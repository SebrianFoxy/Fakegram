import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier.freezed.dart';
part 'messages_notifier.g.dart';
part 'messages_state.dart';

@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  MessagesState build() {
    return const MessagesState.initial();
  }
}