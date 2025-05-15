import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import 'package:provider/provider.dart';
import 'package:ongi/models/signup_form_model.dart';


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
              const Text('서비스 이용 동의', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('서비스 이용을 위해 약관에 동의해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              AgreementItem(
                title: '전체동의',
                subtitle: '서비스 이용을 위해 아래 약관에 모두 동의합니다.',
                isChecked: agreeAll,
                onChanged: toggleAll,
              ),
              const Divider(),
              AgreementItem(
                title: '푸시 알림 제공 동의 (필수)',
                isChecked: agreements[0],
                onChanged: (val) => toggleItem(0, val),
              ),
              AgreementItem(
                title: '보이스 알림 제공 동의 (필수)',
                isChecked: agreements[1],
                onChanged: (val) => toggleItem(1, val),
              ),
              AgreementItem(
                title: '백그라운드 작동 동의 (필수)',
                isChecked: agreements[2],
                onChanged: (val) => toggleItem(2, val),
              ),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () {
                  if (agreements.every((v) => v)) {
                    final form = context.read<SignUpFormModel>();
                    form.pushAgreement = agreements[0];
                    form.voiceAgreement = agreements[1];
                    form.backgroundAgreement = agreements[2];

                    context.push('/signup/signup-input');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 약관에 동의해주세요.')),
                    );
                  }
                },
              )
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
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: Colors.grey))
          : null,
      trailing: const Text('보기', style: TextStyle(color: Colors.grey)),
      contentPadding: EdgeInsets.zero,
      onTap: () => onChanged(!isChecked),
    );
  }
}
