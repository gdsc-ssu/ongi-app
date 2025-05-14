import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ongi/state/account_type.dart';


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

  Future<void> _login() async {
    final baseUrl = 'http://13.124.122.198:8080';
    final id = _idController.text.trim();
    final password = _pwController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'password': password,
          'mode': selectedAccountType == AccountType.guardian ? 'GUARDIAN' : 'SENIOR',
        }),
      );

      final decoded = utf8.decode(response.bodyBytes);
      final json = jsonDecode(decoded);

      if (response.statusCode == 200 && json['success'] == true) {
        final accessToken = json['data']['accessToken'];
        final refreshToken = json['data']['refreshToken'];

        print('로그인 성공');
        print('accessToken: $accessToken');
        print('refreshToken: $refreshToken');


        // 라우터 리빌드
        restartApp?.call();

        // 계정 타입에 따라 홈 화면 이동
        if (selectedAccountType == AccountType.guardian) {
          context.go('/guardian-home');
        } else {
          context.go('/senior-home');
        }
      } else {
        setState(() => _showError = true);
        print('로그인 실패: ${json['message']}');
      }
    } catch (e) {
      print('네트워크 에러: $e');
      setState(() => _showError = true);
    }
  }

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
              const Text('온기, Ongi',
                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('로그인',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              // 아이디 입력
              const Text('아이디'),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // 비밀번호 입력
              const Text('비밀번호'),
              const SizedBox(height: 8),
              TextField(
                controller: _pwController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText:
                      _showError ? '잘못된 비밀번호입니다.' : null,
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
                onPressed: _login,
                child: const Text('로그인'),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  context.push('/signup/terms');
                },
                child: const Text('회원가입'),
              ),
              TextButton(
                onPressed: () => context.push('/find-account'),
                child: const Text('아이디/비밀번호 찾기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
