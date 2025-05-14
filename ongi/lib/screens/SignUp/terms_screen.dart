import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final int currentStep = 1;
  final int totalSteps = 5;

  bool agreeAll = false;
  List<bool> agreements = [false, false, false]; // 개별 3개 항목

  void toggleAll(bool value) {
    setState(() {
      agreeAll = value;
      agreements = List.filled(agreements.length, value);
    });
  }

  void toggleItem(int index, bool value) {
    setState(() {
      agreements[index] = value;
      agreeAll = agreements.every((v) => v); // 모두 true면 전체동의 true
    });
  }

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
              const Text('Terms of Service Agreement', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Please agree to the terms to use the service.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              AgreementItem(
                title: 'Agree to All',
                subtitle: 'By selecting this, you agree to all of the terms below.',
                isChecked: agreeAll,
                onChanged: toggleAll,
              ),
              const Divider(),
              AgreementItem(
                title: 'Consent to Receive Push Notifications (Required)',
                isChecked: agreements[0],
                onChanged: (val) => toggleItem(0, val),
              ),
              AgreementItem(
                title: 'Consent to Voice Notification Service (Required)',
                isChecked: agreements[1],
                onChanged: (val) => toggleItem(1, val),
              ),
              AgreementItem(
                title: 'Consent to Background Operation (Required)',
                isChecked: agreements[2],
                onChanged: (val) => toggleItem(2, val),
              ),

              const Spacer(),

              // ✅ 여기 수정됨
              BottomNextBackNavigation(
                onBack: () => context.go('/account-select'),
                onNext: () => context.push('/signup/signup-input'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgreementItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const AgreementItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isChecked ? Colors.deepOrange : Colors.grey,
        ),
        onPressed: () => onChanged(!isChecked),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: Colors.grey))
          : null,
      trailing: const Text('See Details', style: TextStyle(color: Colors.grey)),
      contentPadding: EdgeInsets.zero,
      onTap: () => onChanged(!isChecked),
    );
  }
}
