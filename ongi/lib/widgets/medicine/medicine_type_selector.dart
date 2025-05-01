import 'package:flutter/material.dart';
import 'prepost_meal_medicine_adder.dart';
import 'timed_medicine_adder.dart';
import 'package:ongi/widgets/medicine/timed_medicine_adder.dart';

class MedicineTypeSelector extends StatefulWidget {
  const MedicineTypeSelector({super.key});

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  final TextEditingController _controller = TextEditingController();
  bool _showError = false;

  void _navigateTo(Widget Function(String medicationName) pageBuilder) {
    if (_controller.text.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pageBuilder(_controller.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputWidth = MediaQuery.of(context).size.width - 80;

    return Container(
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
    );
  }
}
