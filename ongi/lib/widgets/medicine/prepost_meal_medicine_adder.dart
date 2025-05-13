import 'package:flutter/material.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

class PrePostMealMedicineAdder extends StatefulWidget {
  final String medicationName;
  final void Function(Map<String, dynamic>) onSaved;

  const PrePostMealMedicineAdder({
    Key? key,
    required this.medicationName,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<PrePostMealMedicineAdder> createState() => _PrePostMealMedicineAdderState();
}

class _PrePostMealMedicineAdderState extends State<PrePostMealMedicineAdder> {
  String? mealTiming;
  String? beforeAfterTime;

  bool isMorningSelected = false;
  bool isAfternoonSelected = false;
  bool isEveningSelected = false;

  bool get _isValid => mealTiming != null && beforeAfterTime != null;

  List<Widget> _buildRadioRow(List<String> options, String? groupValue, ValueChanged<String> onChanged) {
    return options.map((option) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: option,
            groupValue: groupValue,
            activeColor: Colors.deepOrange,
            onChanged: (val) => onChanged(val!),
          ),
          Text(option),
          const SizedBox(width: 16),
        ],
      );
    }).toList();
  }

  Widget _buildToggle(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? Colors.deepOrange : Colors.black, width: 2),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Before/After Meal (choose one)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: _buildRadioRow(['Before meal', 'After meal'], mealTiming, (val) => setState(() => mealTiming = val)),
        ),
        const SizedBox(height: 16),
        const Text('Medication Time (Multiple selection allowed)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildToggle("Morning", isMorningSelected, () => setState(() => isMorningSelected = !isMorningSelected)),
            _buildToggle("Afternoon ", isAfternoonSelected, () => setState(() => isAfternoonSelected = !isAfternoonSelected)),
            _buildToggle("Evening", isEveningSelected, () => setState(() => isEveningSelected = !isEveningSelected)),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Reminder Time (choose one)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: _buildRadioRow(['30 minutes', '1 hour'], beforeAfterTime, (val) => setState(() => beforeAfterTime = val)),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isValid
                ? () {
                    final medicine = {
                      'name': widget.medicationName,
                      'type': 'prepost',
                      'mealTiming': mealTiming,
                      'beforeAfterTime': beforeAfterTime,
                      'times': [
                        if (isMorningSelected) 'Morning',
                        if (isAfternoonSelected) 'Afternoon ',
                        if (isEveningSelected) 'Evening',
                      ],
                    };
                    widget.onSaved(medicine);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8A50),
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save'),
          ),
        )
      ],
    );
  }
}
