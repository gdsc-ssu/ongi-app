import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import '../../widgets/time_block.dart';

class MealAlertScheduleScreen extends StatefulWidget {
  const MealAlertScheduleScreen({super.key});

  @override
  State<MealAlertScheduleScreen> createState() => _MealAlertScheduleScreenState();
}

class _MealAlertScheduleScreenState extends State<MealAlertScheduleScreen> {
  final int currentStep = 4;
  final int totalSteps = 5;

  List<Map<String, dynamic>> mealTimes = [
  {'label': 'Lunch', 'time': TimeOfDay(hour: 12, minute: 30)}
];

  void _showTimePickerSheet() {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TextEditingController _titleController = TextEditingController();


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
                  const Text('Set Title', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Please enter a title.',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
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
                        child: const Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_titleController.text.trim().isNotEmpty) {
                            setState(() {
                              mealTimes.add({
                                'label': _titleController.text.trim(),
                                'time': selectedTime
                              });
                            });
                            Navigator.pop(context);
                            _titleController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        child: const Text('Confirm'),
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
              const Text('Meal Reminder Schedule', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Please enter the meal time.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ...mealTimes.map((entry) => TimeBlock(
                label: entry['label'],
                time: entry['time'],
              )).toList(),
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
