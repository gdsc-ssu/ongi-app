import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import 'package:provider/provider.dart';
import 'package:ongi/models/signup_form_model.dart';

class AlertSettingScreen extends StatefulWidget {
  const AlertSettingScreen({super.key});

  @override
  State<AlertSettingScreen> createState() => _AlertSettingScreenState();
}

class _AlertSettingScreenState extends State<AlertSettingScreen> {
  final int currentStep = 5;
  final int totalSteps = 5;

  final TextEditingController _countController = TextEditingController();
  int? selectedInterval; 
  
  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  Widget _buildRadioOption(int value, String label) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: selectedInterval,
          onChanged: (val) {
            setState(() {
              selectedInterval = val;
            });
          },
        ),
        Text(label),
      ],
    );
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
              const Text('알림 방식 설정', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                '응답 누락 횟수가 초과하면 노약자의 안전 확인을 위해 보호자에게 긴급 상황 알림을 전송하게 됩니다.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const Text('응답 누락 허용 횟수 입력'),
              const SizedBox(height: 8),
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '예: 3',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 32),
              const Text('미응답 시 재알림 간격'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildRadioOption(30, '30분'),
                  _buildRadioOption(60, '1시간'),
                ],
              ),
              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () {
                  final form = context.read<SignUpFormModel>();
                  form.ignoreCnt = int.tryParse(_countController.text) ?? 3;
                  form.alertMax = selectedInterval == 30 ? "MINUTES_30" : "MINUTES_60";
                  context.push('/signup/voice-setting');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
