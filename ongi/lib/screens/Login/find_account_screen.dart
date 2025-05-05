import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FindAccountScreen extends StatelessWidget {
  const FindAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final codeController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('아이디/비밀번호 찾기',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              const Text('전화번호'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: '전화번호를 입력해주세요.',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('인증번호 받기'),
                  )
                ],
              ),
              const SizedBox(height: 20),

              const Text('인증번호 입력'),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  hintText: '인증번호를 입력해주세요.',
                ),
              ),
              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('이전'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/find-account-result');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFAE87),
                      ),
                      child: const Text('다음'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
