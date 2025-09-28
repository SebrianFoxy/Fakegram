import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../notifier/auth_notifier.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, String?>((ref) => AuthNotifier());
final refreshTokenProvider = StateProvider<String?>((ref) => null);

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _isRegister = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final username = _usernameController.text.trim();
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        (_isRegister && username.isEmpty)) {
      _showError("Заполните все поля");
      return;
    }

    if (_isRegister && password != confirmPassword) {
      _showError("Пароли не совпадают");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = _isRegister
          ? 'http://localhost:8080/api/v1/users'
          : 'http://localhost:8080/api/v1/auth/login';

      final body = _isRegister
          ? jsonEncode(
              {'email': email, 'password': password, 'username': username})
          : jsonEncode({'email': email, 'password': password});

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (!_isRegister) {
          final token = data['token'] as String?;
          final refreshToken = data['refresh_token'] as String?;

          if (token != null && refreshToken != null) {
            ref.read(authProvider.notifier).setToken(token);
            ref.read(refreshTokenProvider.notifier).state = refreshToken;

            _showError("Авторизация прошла успешно!");
          } else {
            _showError("Токены не получены");
          }
        } else {
          setState(() => _isRegister = false);
          _showError("Регистрация успешна! Войдите в систему.");
        }
      } else {
        _showError('Ошибка: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Ошибка сети: $e');
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMode() {
    setState(() {
      _isRegister = !_isRegister;
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isRegister ? "Регистрация" : "Авторизация")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_isRegister) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                )
              ],
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_isRegister) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder()),
                )
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(_isRegister ? "Register" : "Log In")),
              ),
              const SizedBox(height: 12),
              TextButton(
                  onPressed: _toggleMode,
                  child: Text(_isRegister
                      ? "Уже есть аккаунт? Войти"
                      : "Нет аккаунта? Зарегистрироваться"))
            ],
          ),
        ),
      ),
    );
  }
}
