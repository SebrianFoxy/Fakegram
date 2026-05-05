import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/auth_notifier.dart';
import '../widgets/glass_morphism_container.dart';
import '../widgets/gradient_background.dart';
import '../widgets/dark_overlay.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnimatedSnackBar.material(
        message,
        type: AnimatedSnackBarType.error,
        desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
      ).show(context);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    await ref.read(authProvider.notifier).login(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      switch (next) {
        case AuthStateInitial(:final error):
          if (error != null && error.isNotEmpty) {
            _showError(error);
          }
        default:
          break;
      }
    });

    return Scaffold(
      body: GradientBackground(
        child: switch (authState) {
          AuthStateInitial() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                const DarkOverlay(),
                GlassMorphismContainer(
                  child: LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onLogin: _handleLogin,
                  ),
                ),
              ],
            ),
          ),
          AuthStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          _ => const Center(
            child: CircularProgressIndicator(),
          ),
        },
      ),
    );
  }
}