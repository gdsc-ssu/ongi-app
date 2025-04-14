import 'package:flutter/material.dart';
import 'timed_medication_adder.dart';
import 'prepost_meal_medication_adder.dart';

class MedicationTypeSelector extends StatefulWidget {
  const MedicationTypeSelector({super.key});

  @override
  State<MedicationTypeSelector> createState() => _MedicationTypeSelectorState();
}

class _MedicationTypeSelectorState extends State<MedicationTypeSelector> {
  final TextEditingController _medicationNameController = TextEditingController();

  @override
  void dispose() {
    _medicationNameController.dispose();
    super.dispose();
  }

  void _navigateToTimedMedicationAdder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimedMedicationAdder(
          medicationName: _medicationNameController.text,
        ),
      ),
    );
  }

  void _navigateToPrePostMealMedicationAdder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrePostMealMedicationAdder(
          medicationName: _medicationNameController.text,
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
            controller: _medicationNameController,
            decoration: const InputDecoration(
              labelText: '약 이름을 입력해주세요',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToPrePostMealMedicationAdder,
            child: const Text('식전/식후 복용 약'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _navigateToTimedMedicationAdder,
            child: const Text('정시 복용 약'),
          ),
        ],
      ),
    );
  }
}
