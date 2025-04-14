import 'package:flutter/material.dart';
import 'package:ongi/components/medicine/prepost_meal_medicine_adder.dart';
import 'package:ongi/components/medicine/timed_medicine_adder.dart';

class MedicineTypeSelector extends StatefulWidget {
  const MedicineTypeSelector({Key? key}) : super(key: key);

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _navigateToPrePostMeal() {
    if (_controller.text.isEmpty) {
      setState(() {
        _errorText = '약 이름을 입력해주세요';
      });
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrePostMealMedicineAdder(medicationName: _controller.text),
      ),
    );
  }

  void _navigateToTimedMedicine() {
    if (_controller.text.isEmpty) {
      setState(() {
        _errorText = '약 이름을 입력해주세요';
      });
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimedMedicineAdder(medicationName: _controller.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '약 이름을 입력하세요',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                  hintText: '약 이름을 입력해주세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.deepOrange, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _navigateToPrePostMeal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade50,
                  foregroundColor: Colors.deepOrange,
                  elevation: 2,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('식전/식후 복용 약', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _navigateToTimedMedicine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade50,
                  foregroundColor: Colors.deepOrange,
                  elevation: 2,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('정시 복용 약', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
