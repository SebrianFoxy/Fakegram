import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null);

  void setToken(String token) {
    log('[AuthNotifier] setToken is called: $token');
    state = token;
  }

  void clearToken() {
    log('[AuthNotifier] clearToken is called');
    state = null;
  }
}
