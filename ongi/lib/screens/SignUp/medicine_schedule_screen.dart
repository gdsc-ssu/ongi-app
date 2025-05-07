import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import '../../widgets/time_block.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';
import 'package:flutter/cupertino.dart';


class MedicineScheduleScreen extends StatefulWidget {
  const MedicineScheduleScreen({super.key});

  @override
  State<MedicineScheduleScreen> createState() => _MedicineScheduleScreenState();
}

class _MedicineScheduleScreenState extends State<MedicineScheduleScreen> {
  final int currentStep = 4;
  final int totalSteps = 5;

  List<TimeOfDay> medicineTimes = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
  ];

  void _showTimePickerSheet() {
    TimeOfDay selectedTime = TimeOfDay.now();

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
                  const Text('복용 시간 설정', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 150,
                    child: TimePickerSpinner(
                      initialTime: selectedTime,
                      onTimeChanged: (time) {
                        setModalState(() {
                          selectedTime = time;
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
                        onPressed: () {
                          setState(() {
                            medicineTimes.add(selectedTime);
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
              const Text('약 복용 알림 스케줄', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('약 정보를 입력해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              const MedicineTypeSelector(),
              const SizedBox(height: 24),

              ...medicineTimes.map((time) => TimeBlock(label: '비타민', time: time)).toList(),

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
                onNext: () => context.push('/signup/alert-setting'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimePickerSpinner extends StatelessWidget {
  final TimeOfDay initialTime;
  final void Function(TimeOfDay) onTimeChanged;

  const TimePickerSpinner({super.key, required this.initialTime, required this.onTimeChanged});

  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      initialTimerDuration: Duration(hours: initialTime.hour, minutes: initialTime.minute),
      onTimerDurationChanged: (duration) {
        onTimeChanged(TimeOfDay(hour: duration.inHours % 24, minute: duration.inMinutes % 60));
      },
    );
  }
}
