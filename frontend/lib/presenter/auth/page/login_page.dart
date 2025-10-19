import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:fakegram/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fakegram/presenter/auth/notifier/auth_notifier.dart';
import 'package:fakegram/core/routes/app_router.dart';

import '../../../core/theme/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authNotifierProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      switch (next) {
        case AuthStateInitial(:final error):
          if (error != null && error.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AnimatedSnackBar.material(
                error,
                type: AnimatedSnackBarType.error,
                desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
              ).show(context);
            });
          }
        case _:
          break;
      }
    });

    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemes.mainGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: switch (authState) {
            AuthStateInitial() => _buildLoginForm(context),
            AuthStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            _ => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
            child: Container(),
          ),
        ),

        Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.overlay,
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(32),
                    decoration: AppThemes.glassMorphismDecoration,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.lock_outlined,
                                    color: theme.colorScheme.primaryContainer,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Welcome Back',
                                  style: theme.textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Please sign in to your account',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          Text(
                            'Email Address',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _emailController,
                              hintText: 'Enter your email',
                              prefixIcon: Icons.email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Password',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _passwordController,
                              hintText: 'Enter your password',
                              prefixIcon: Icons.lock_outlined,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          Container(
                            decoration: AppThemes.buttonShadowDecoration,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _login,
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: theme.dividerTheme.color),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Divider(color: theme.dividerTheme.color),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    AppRouter.goToRegistration(context);
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: theme.colorScheme.primaryContainer,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}