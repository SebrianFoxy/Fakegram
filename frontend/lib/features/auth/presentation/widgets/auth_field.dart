import 'package:fakegram/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'auth_input.dart';

class AuthField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const AuthField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          decoration: AppThemes.inputShadowDecoration,
          child: AuthInput(
            controller: controller,
            hintText: hintText,
            prefixIcon: prefixIcon,
            obscureText: obscureText,
            suffixIcon: suffixIcon,
            validator: validator,
          ),
        ),
      ],
    );
  }
}