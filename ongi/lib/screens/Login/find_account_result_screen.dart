import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FindAccountResultScreen extends StatelessWidget {
  const FindAccountResultScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Find ID/Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              const Text('Username'),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: 'iddlqslek'),
              ),
              const SizedBox(height: 20),

              const Text('Password'),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: 'qlaflqisghd'),
              ),
              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  context.push('/login'); // 로그인 화면으로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFAE87),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Go to Login / Back to Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
