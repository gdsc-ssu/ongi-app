import 'package:flutter/material.dart';

class PrePostMealMedicationAdder extends StatelessWidget {
  final String medicationName;

  const PrePostMealMedicationAdder({super.key, required this.medicationName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$medicationName - 식전/식후 복용 추가')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('식전/식후/시간 선택 라디오 버튼 (TODO)'),
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
