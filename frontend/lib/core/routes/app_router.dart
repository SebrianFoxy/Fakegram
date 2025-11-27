import 'package:fakegram/presenter/auth/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../presenter/auth/page/login_page.dart';
import '../../presenter/auth/page/registration_page.dart';
import '../../presenter/chat/page/messages.dart';
import '../../presenter/profile/page/profile.dart';

part 'app_router.g.dart';

final _logger = Logger('AppRouter');

@riverpod
GoRouter goRouter(Ref ref) {
  final refreshNotifier = _GoRouterRefreshNotifier(ref);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final currentPath = state.uri.path;
      final publicRoutes = ['/login', '/registration'];
      final isPublicRoute = publicRoutes.contains(currentPath);

      _logger.fine('[redirect] authState=$authState, path=$currentPath');

      if (authState.isAuthenticated && isPublicRoute) {
        return '/chat';
      }

      if (!authState.isAuthenticated && !isPublicRoute) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/registration',
        name: 'registration',
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const MessagesPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.path}'),
      ),
    ),
  );
}

class _GoRouterRefreshNotifier extends ChangeNotifier {
  _GoRouterRefreshNotifier(this.ref) {
    _subscription = ref.listen<AuthState>(
      authNotifierProvider,
          (_, __) => notifyListeners(),
    );
  }

  final Ref ref;
  late final ProviderSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

class AppRouter {
  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  static void goToRegistration(BuildContext context) {
    context.go('/registration');
  }

  static void goToMessages(BuildContext context) {
    context.go('/chat');
  }

  static void goToProfile(BuildContext context) {
    context.go('/profile');
  }

  static void pushLogin(BuildContext context) {
    context.push('/login');
  }

  static void pushRegistration(BuildContext context) {
    context.push('/registration');
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void goNamed(BuildContext context, String name, {Map<String, String> params = const {}}) {
    context.goNamed(name, pathParameters: params);
  }
}