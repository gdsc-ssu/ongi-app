import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  bool _obscureText = true;
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text('Ongi',
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('Log In',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              // 아이디 입력
              const Text('Username'),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // 비밀번호 입력
              const Text('Password'),
              const SizedBox(height: 8),
              TextField(
                controller: _pwController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText:
                      _showError ? 'ncorrect password.' : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFAE87),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  setState(() {
                    _showError = _pwController.text != '123456';
                  });
                },
                child: const Text('Log In'),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  context.push('/signup/terms');
                },
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () => context.push('/find-account'),
                child: const Text('Find ID/Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
