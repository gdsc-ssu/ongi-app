// ✅ 수정 포인트 반영을 위한 전체 파일 업데이트 시작
// 변경 대상: medicine_type_selector.dart

import 'package:flutter/material.dart';
import 'prepost_meal_medicine_adder.dart';
import 'timed_medicine_adder.dart';
import 'package:go_router/go_router.dart'; // GoRouter 사용

class MedicineTypeSelector extends StatefulWidget {
  const MedicineTypeSelector({super.key});

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  final TextEditingController _controller = TextEditingController();
  bool _showError = false;

  Future<void> _navigateTo(Widget Function(String medicationName) pageBuilder) async {
  if (_controller.text.isEmpty) {
    setState(() => _showError = true);
    return;
  }

  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pageBuilder(_controller.text)),
  );

  if (result != null) {
    Navigator.pop(context, result); // 약 정보 부모에게 전달
  }
}


  @override
  Widget build(BuildContext context) {
    final inputWidth = MediaQuery.of(context).size.width - 80;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Row(
            children: [
              SizedBox(width: 8),
              Icon(Icons.arrow_back_ios, color: Colors.black),
              Text("이전", style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: inputWidth + 40,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '약 이름을 입력해주세요',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '약 이름을 입력해주세요',
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_showError)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '약 이름을 입력해주세요',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              const SizedBox(height: 16),
              Column(
                children: [
                  SizedBox(
                    width: inputWidth,
                    child: OutlinedButton(
                      onPressed: () => _navigateTo((name) => PrePostMealMedicineAdder(medicationName: name)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('식전/식후 복용 약', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: inputWidth,
                    child: OutlinedButton(
                      onPressed: () => _navigateTo((name) => TimedMedicineAdder(medicationName: name)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('정시 복용 약', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
