import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/auth_notifier.dart';
import '../widgets/glass_morphism_container.dart';
import '../widgets/gradient_background.dart';
import '../widgets/dark_overlay.dart';
import '../widgets/registration_form.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    await ref.read(authNotifierProvider.notifier).registration(
      _emailController.text.trim(),
      _firstNameController.text,
      _lastNameController.text,
      _nicknameController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    void _showError(String message) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AnimatedSnackBar.material(
          message,
          type: AnimatedSnackBarType.error,
          desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
        ).show(context);
      });
    }

    void _showSuccess(String message) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AnimatedSnackBar.material(
          message,
          type: AnimatedSnackBarType.success,
          desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
        ).show(context);
      });
    }

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      switch (next) {
        case AuthStateInitial(:final error):
          if (error != null && error.isNotEmpty) {
            _showError(error);
          }
        case AuthStateRegistrationSuccess():
          _showSuccess('Account confirmation has been sent to your email.');
        default:
          break;
      }
    });

    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              const DarkOverlay(),
              if (authState is AuthStateLoading)
                const Center(child: CircularProgressIndicator())
              else
                GlassMorphismContainer(
                  child: RegistrationForm(
                    emailController: _emailController,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    nicknameController: _nicknameController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onRegister: _handleRegister,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}