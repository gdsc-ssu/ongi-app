import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import '../../models/signup_form_model.dart';

class SignupInputScreen extends StatelessWidget {
  const SignupInputScreen({super.key});

  final int currentStep = 2;
  final int totalSteps = 5;

  @override
  Widget build(BuildContext context) {
    final _idController = TextEditingController();
    final _pwController = TextEditingController();
    final _pwConfirmController = TextEditingController();
    final _phoneController = TextEditingController();
    final _verifyController = TextEditingController();
    final _nameController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProgressStepIndicator(currentStep: currentStep, totalSteps: totalSteps),
              const SizedBox(height: 24),
              const Text(
                '회원가입',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('회원가입 정보를 입력해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              _InputField(label: '아이디', hint: '아이디를 입력해주세요.', controller: _idController, hasButton: true, buttonText: '중복확인'),
              _InputField(label: '비밀번호', hint: '비밀번호를 입력해주세요.', controller: _pwController, obscureText: true),
              _InputField(label: '비밀번호 확인', hint: '비밀번호를 다시 한 번 입력해주세요.', controller: _pwConfirmController, obscureText: true),
              _InputField(label: '전화번호', hint: '전화번호를 입력해주세요.', controller: _phoneController, hasButton: true, buttonText: '인증번호 받기'),
              _InputField(label: '인증번호', hint: '인증번호를 입력해주세요.', controller: _verifyController, hasButton: true, buttonText: '확인'),
              _InputField(label: '성함', hint: '성함을 입력해주세요.', controller: _nameController),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () {
                  final form = context.read<SignUpFormModel>();
                  form.loginId = _idController.text.trim();
                  form.password = _pwController.text.trim();
                  form.guardianPhoneNumber = _phoneController.text.trim();
                  form.guardianName = _nameController.text.trim();

                  context.push('/signup/senior-info');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final bool hasButton;
  final String? buttonText;
  final TextEditingController? controller;

  const _InputField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.hasButton = false,
    this.buttonText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
            if (hasButton && buttonText != null) ...[
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  minimumSize: const Size(0, 48),
                ),
                child: Text(buttonText!),
              ),
            ]
          ],
        )
      ],
    );
  }
}