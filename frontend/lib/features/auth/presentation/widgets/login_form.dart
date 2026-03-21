import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import '../notifier/auth_notifier.dart';
import 'auth_field.dart';
import 'auth_button.dart';
import 'auth_header.dart';
import 'auth_divider.dart';
import 'auth_switch_row.dart';
import '../../../../core/routes/app_router.dart';

class LoginForm extends ConsumerStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin();
    }
  }

  void _navigateToRegistration() {
    AppRouter.goToRegistration(context);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthHeader(
            icon: Icons.lock_outlined,
            title: 'Welcome Back',
            subtitle: 'Please sign in to your account',
          ),
          const SizedBox(height: 32),
          AuthField(
            label: 'Email Address',
            controller: widget.emailController,
            hintText: 'Enter your email',
            prefixIcon: Icons.email,
            validator: _validateEmail,
          ),
          const SizedBox(height: 20),
          AuthField(
            label: 'Password',
            controller: widget.passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outlined,
            obscureText: true,
            validator: _validatePassword,
          ),
          const SizedBox(height: 24),
          AuthButton(
            text: 'Sign In',
            onPressed: _handleLogin,
          ),
          const SizedBox(height: 24),
          const AuthDivider(),
          const SizedBox(height: 16),
          AuthSwitchRow(
            question: "Don't have an account?",
            actionText: 'Sign up',
            onTap: _navigateToRegistration,
          ),
        ],
      ),
    );
  }
}