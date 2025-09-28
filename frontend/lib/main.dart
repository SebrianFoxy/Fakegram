import 'dart:developer';

import 'package:fakegram/presenter/auth/page/auth.dart';
import 'package:fakegram/presenter/messages/page/messages.dart';
import 'package:fakegram/presenter/profile/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

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

enum AppRoute {
  messages,
}

class Fakegram extends ConsumerWidget {
  const Fakegram({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(authProvider);

    final router = GoRouter(
      initialLocation: '/messages',
      redirect: (context, state) {
        final loggingIn = state.uri.path == '/auth';
        log('[redirect] token=$token, loggingIn=$loggingIn, location=${state.uri.path}');

        if (token == null && !loggingIn) return '/auth';
        if (token != null && loggingIn) return '/messages';
        return null;
      },
      routes: [
        GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
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
