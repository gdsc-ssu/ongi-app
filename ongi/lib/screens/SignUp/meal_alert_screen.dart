import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import '../../widgets/time_block.dart';
import '../../models/signup_form_model.dart';

class MealAlertScheduleScreen extends StatefulWidget {
  const MealAlertScheduleScreen({super.key});

  @override
  State<MealAlertScheduleScreen> createState() => _MealAlertScheduleScreenState();
}

class _MealAlertScheduleScreenState extends State<MealAlertScheduleScreen> {
  final int currentStep = 4;
  final int totalSteps = 5;

  List<Map<String, dynamic>> mealTimes = [];

  void _showTimePickerSheet() {
    TimeOfDay selectedTime = TimeOfDay.now();
    String? selectedLabel;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('식사 종류 선택', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedLabel,
                    items: ['아침', '점심', '저녁']
                        .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                        .toList(),
                    onChanged: (val) => setModalState(() => selectedLabel = val),
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 150,
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: Duration(hours: selectedTime.hour, minutes: selectedTime.minute),
                      onTimerDurationChanged: (duration) {
                        setModalState(() {
                          selectedTime = TimeOfDay(hour: duration.inHours % 24, minute: duration.inMinutes % 60);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('닫기'),
                      ),
                      ElevatedButton(
                        onPressed: selectedLabel == null
                            ? null
                            : () {
                                final form = context.read<SignUpFormModel>();

                                final typeCode = {
                                  '아침': 'BREAKFAST',
                                  '점심': 'LUNCH',
                                  '저녁': 'DINNER',
                                }[selectedLabel]!;

                                form.addMeal(
                                  type: typeCode,
                                  time: selectedTime,
                                );

                                setState(() {
                                  mealTimes.add({
                                    'label': '$selectedLabel식사',
                                    'time': selectedTime,
                                  });
                                });

                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        child: const Text('확인'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
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
              const Text('식사 알림 스케줄', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('식사시간을 입력해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              ...mealTimes.map((entry) => TimeBlock(
                label: entry['label'],
                time: entry['time'],
              )),

              const SizedBox(height: 16),
              Center(
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 36, color: Colors.grey),
                  onPressed: _showTimePickerSheet,
                ),
              ),
              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () => context.push('/signup/medicine-schedule'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
