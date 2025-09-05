import 'package:fakegram/presenter/profile/page/profile.dart';
import 'presenter/messages/page/messages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final GoRouter _router = GoRouter(
  initialLocation: '/messages',
  routes: <RouteBase>[
    GoRoute(
      path: '/messages',
      name: AppRoute.messages.name,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const MessagesPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
  ],
);

class Fakegram extends StatefulWidget {
  const Fakegram({super.key});

  @override
  State<Fakegram> createState() => _FakegramState();
}

class _FakegramState extends State<Fakegram> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
