import 'package:flutter/material.dart';

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
        const Text('식전/식후 (택 1)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: _buildRadioRow(['식전', '식후'], mealTiming, (val) => setState(() => mealTiming = val)),
        ),
        const SizedBox(height: 16),
        const Text('복용 시간 (중복 선택 가능)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildToggle("아침", isMorningSelected, () => setState(() => isMorningSelected = !isMorningSelected)),
            _buildToggle("점심", isAfternoonSelected, () => setState(() => isAfternoonSelected = !isAfternoonSelected)),
            _buildToggle("저녁", isEveningSelected, () => setState(() => isEveningSelected = !isEveningSelected)),
          ],
        ),
        const SizedBox(height: 16),
        const Text('알림 시간 (택 1)', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: _buildRadioRow(['30분', '1시간'], beforeAfterTime, (val) => setState(() => beforeAfterTime = val)),
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
                        if (isMorningSelected) '아침',
                        if (isAfternoonSelected) '점심',
                        if (isEveningSelected) '저녁',
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
            child: const Text('저장'),
          ),
        )
      ],
    );
  }
}
