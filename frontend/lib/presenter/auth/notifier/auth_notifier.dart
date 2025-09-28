import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';
part 'auth_state.dart';

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null);

  void setToken(String token) {
    log('[AuthNotifier] setToken is called: $token');
    state = token;
  }

}
