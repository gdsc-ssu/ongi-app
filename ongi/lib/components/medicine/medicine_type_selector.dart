import 'package:flutter/material.dart';
import 'timed_medicine_adder.dart';
import 'prepost_meal_medicine_adder.dart';

class MedicineTypeSelector extends StatefulWidget {
  const MedicineTypeSelector({super.key});

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  final TextEditingController _medicineNameController = TextEditingController();

  @override
  void dispose() {
    _medicineNameController.dispose();
    super.dispose();
  }

  void _navigateToTimedMedicineAdder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimedMedicineAdder(
          medicineName: _medicineNameController.text,
        ),
      ),
    );
  }

  void _navigateToPrePostMealMedicineAdder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrePostMealMedicineAdder(
          medicineName: _medicineNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // 전체 배경 색 연한 회색
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '약 이름',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _medicineNameController,
                decoration: InputDecoration(
                  hintText: '약 이름을 입력해주세요.',
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: _navigateToPrePostMealMedicineAdder,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '식전/식후 복용 약',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: _navigateToTimedMedicineAdder,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '정시 복용 약',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
