import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_field.dart';
import 'auth_button.dart';
import 'auth_header.dart';
import 'auth_divider.dart';
import 'auth_switch_row.dart';
import '../../../../core/routes/app_router.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController nicknameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;

  const RegistrationForm({
    super.key,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.nicknameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
  });

  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      widget.onRegister();
    }
  }

  void _navigateToLogin() {
    AppRouter.goToLogin(context);
  }

  String? _validateRequired(String? value, String fieldName, {int minLength = 2}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (widget.passwordController.text != widget.confirmPasswordController.text) {
      return 'Passwords do not match';
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
            icon: Icons.person_add_outlined,
            title: 'Create Account',
            subtitle: 'Please fill in your details',
          ),
          const SizedBox(height: 32),
          AuthField(
            label: 'First Name',
            controller: widget.firstNameController,
            hintText: 'Enter your first name',
            prefixIcon: Icons.person_outline,
            validator: (value) => _validateRequired(value, 'first name', minLength: 2),
          ),
          const SizedBox(height: 20),
          AuthField(
            label: 'Last Name',
            controller: widget.lastNameController,
            hintText: 'Enter your last name',
            prefixIcon: Icons.person_outline,
            validator: (value) => _validateRequired(value, 'last name', minLength: 2),
          ),
          const SizedBox(height: 20),
          AuthField(
            label: 'Nickname',
            controller: widget.nicknameController,
            hintText: 'Enter your nickname',
            prefixIcon: Icons.alternate_email,
            validator: (value) => _validateRequired(value, 'nickname', minLength: 3),
          ),
          const SizedBox(height: 20),
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
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: _validatePassword,
          ),
          const SizedBox(height: 20),
          AuthField(
            label: 'Confirm Password',
            controller: widget.confirmPasswordController,
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_outlined,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: _validateConfirmPassword,
          ),
          const SizedBox(height: 24),
          AuthButton(
            text: 'Sign up',
            onPressed: _handleRegister,
          ),
          const SizedBox(height: 24),
          const AuthDivider(),
          const SizedBox(height: 16),
          AuthSwitchRow(
            question: 'Already have an account?',
            actionText: 'Sign in',
            onTap: _navigateToLogin,
          ),
        ],
      ),
    );
  }
}