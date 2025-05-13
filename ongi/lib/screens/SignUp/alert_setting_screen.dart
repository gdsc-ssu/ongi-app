import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';

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
              const Text('Notification Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                'If the number of missed responses exceeds the limit, an emergency alert will be sent to the caregiver to ensure the elder’s safety.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const Text('Set allowed number of missed responses'),
              const SizedBox(height: 8),
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '	e.x., 3',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Reminder interval after no response'),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildRadioOption(30, '30 minutes'),
                  _buildRadioOption(60, '1 hour'),
                ],
              ),
              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () => context.push('/signup/voice-setting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
