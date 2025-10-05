import 'dart:developer';

import 'package:fakegram/presenter/auth/page/auth.dart';
import 'package:fakegram/presenter/messages/page/messages.dart';
import 'package:fakegram/presenter/profile/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'presenter/auth/page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(300, 400),
    size: Size(800, 600),
    center: true,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(ProviderScope(
    child: Fakegram(),
  ));
}

class Fakegram extends ConsumerWidget {
  const Fakegram({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = null;

    final router = GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final loggingIn = state.uri.path == '/login';
        log('[redirect] token=$token, loggingIn=$loggingIn, location=${state.uri.path}');

        if (token == null && !loggingIn) return '/login';
        if (token != null && loggingIn) return '/messages';
        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
            path: '/messages',
            builder: (context, state) => const MessagesPage()),
        GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage()),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
