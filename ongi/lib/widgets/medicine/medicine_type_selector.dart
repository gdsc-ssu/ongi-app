import 'package:flutter/material.dart';
import 'prepost_meal_medicine_adder.dart';
import 'timed_medicine_adder.dart';

enum MedicineInputType { none, prepost, timed }

class MedicineTypeSelector extends StatefulWidget {
  final void Function(Map<String, dynamic>) onMedicineAdded;

  const MedicineTypeSelector({super.key, required this.onMedicineAdded});

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  final TextEditingController _controller = TextEditingController();
  bool _showError = false;
  MedicineInputType _inputType = MedicineInputType.none;

  void _selectType(MedicineInputType type) {
    if (_controller.text.trim().isEmpty) {
      setState(() => _showError = true);
      return;
    }
    setState(() {
      _inputType = type;
      _showError = false;
    });
  }

  void _handleSaved(Map<String, dynamic> medicine) {
    widget.onMedicineAdded(medicine);
    setState(() {
      _inputType = MedicineInputType.none;
      _controller.clear();
    });
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
            'Input medication name.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Input medication name.',
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
                'Please enter the medication name.',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          const SizedBox(height: 16),

          if (_inputType == MedicineInputType.none) ...[
            SizedBox(
              width: inputWidth,
              child: OutlinedButton(
                onPressed: () => _selectType(MedicineInputType.prepost),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('	Before/After Meal Medication', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: inputWidth,
              child: OutlinedButton(
                onPressed: () => _selectType(MedicineInputType.timed),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Scheduled Time Medication', style: TextStyle(color: Colors.black)),
              ),
            ),
          ]
          else if (_inputType == MedicineInputType.prepost) ...[
            const SizedBox(height: 12),
            PrePostMealMedicineAdder(
              medicationName: _controller.text.trim(),
              onSaved: _handleSaved,
            ),
          ]
          else if (_inputType == MedicineInputType.timed) ...[
            const SizedBox(height: 12),
            TimedMedicineAdder(
              medicationName: _controller.text.trim(),
              onSaved: _handleSaved,
            ),
          ],
        ],
      ),
    );
  }
}
