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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _medicineNameController,
            decoration: const InputDecoration(
              labelText: '약 이름을 입력해주세요',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToPrePostMealMedicineAdder,
            child: const Text('식전/식후 복용 약'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _navigateToTimedMedicineAdder,
            child: const Text('정시 복용 약'),
          ),
        ],
      ),
    );
  }
}
