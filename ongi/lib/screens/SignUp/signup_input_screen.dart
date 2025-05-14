import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';

class SignupInputScreen extends StatelessWidget {
  const SignupInputScreen({super.key});

  final int currentStep = 2;
  final int totalSteps = 5;

  @override
  Widget build(BuildContext context) {
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
                'Sign Up',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign Up',

              ),
              const SizedBox(height: 24),

              const _InputField(label: 'Username', hint: 'Please enter your username.', hasButton: true, buttonText: 'Check Availability'),
              const _InputField(label: 'Password', hint: 'Please enter your password.', obscureText: true),
              const _InputField(label: 'Confirm Password', hint: 'Please re-enter your password.', obscureText: true),
              const _InputField(label: 'Phone Number', hint: 'Please enter your phone number.', hasButton: true, buttonText: 'Get Verification Code'),
              const _InputField(label: 'Verification Code', hint: 'Please enter the verification code.', hasButton: true, buttonText: 'Confirm'),
              const _InputField(label: 'Full Name', hint: 'Please enter the full name.'),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () => context.push('/signup/senior-info'),
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

  const _InputField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.hasButton = false,
    this.buttonText,
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
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(fontSize: 14), // ✅ hint 크기 2px 줄임
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
                child: Text(
  buttonText!,
  style: const TextStyle(fontWeight: FontWeight.normal), // ✅ Bold 제거
),

              ),
            ]
          ],
        )
      ],
    );
  }
}