import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:fakegram/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/widgets.dart';
import '../notifier/auth_notifier.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _firstPasswordController = TextEditingController();
  final _secondPasswordController = TextEditingController();
  bool _obscureFirstPassword = true;
  bool _obscureSecondPassword = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authNotifierProvider.notifier).registration(
          _emailController.text.trim(),
          _firstNameController.text,
          _secondNameController.text,
          _nicknameController.text,
          _firstPasswordController.text
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _secondNameController.dispose();
    _nicknameController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
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
        case AuthStateRegistrationSuccess():
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AnimatedSnackBar.material(
              'Account confirmation has been sent to your email.',
              type: AnimatedSnackBarType.success,
              desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
            ).show(context);
          });
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
            AuthStateInitial() => _buildRegistrationForm(context),
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

  Widget _buildRegistrationForm(BuildContext context) {
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
                                    Icons.person_add_outlined,
                                    color: theme.colorScheme.primaryContainer,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Create Account',
                                  style: theme.textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Please fill in your details',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          Text(
                            'First Name',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _firstNameController,
                              hintText: 'Enter your first name',
                              prefixIcon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                if (value.length < 2) {
                                  return 'First name must be at least 2 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Last Name',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _secondNameController,
                              hintText: 'Enter your last name',
                              prefixIcon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                if (value.length < 2) {
                                  return 'Last name must be at least 2 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Nickname',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _nicknameController,
                              hintText: 'Enter your nickname',
                              prefixIcon: Icons.alternate_email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your nickname';
                                }
                                if (value.length < 3) {
                                  return 'Nickname must be at least 3 characters';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

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
                              controller: _firstPasswordController,
                              hintText: 'Enter your password',
                              prefixIcon: Icons.lock_outlined,
                              obscureText: _obscureFirstPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureFirstPassword ? Icons.visibility : Icons.visibility_off,
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureFirstPassword = !_obscureFirstPassword;
                                  });
                                },
                              ),
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

                          const SizedBox(height: 20),

                          Text(
                            'Confirm Password',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: AppThemes.inputShadowDecoration,
                            child: AuthInput(
                              controller: _secondPasswordController,
                              hintText: 'Confirm your password',
                              prefixIcon: Icons.lock_outlined,
                              obscureText: _obscureSecondPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureSecondPassword ? Icons.visibility : Icons.visibility_off,
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureSecondPassword = !_obscureSecondPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (_firstPasswordController.text != _secondPasswordController.text) {
                                  return 'Passwords do not match';
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
                                onPressed: _register,
                                child: const Text(
                                  'Sign up',
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
                                  "Already have an account?",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    AppRouter.goToLogin(context);
                                  },
                                  child: Text(
                                    'Sign in',
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