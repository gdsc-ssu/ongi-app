import 'package:flutter/material.dart';

class TimedMedicationAdder extends StatelessWidget {
  final String medicationName;

  const TimedMedicationAdder({super.key, required this.medicationName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$medicationName - 정시 복용 추가')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('시간 다이얼 (TODO)'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
