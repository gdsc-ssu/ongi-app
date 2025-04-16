import 'package:flutter/material.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

class PrePostMealMedicineAdder extends StatefulWidget {
  final String medicationName;

  const PrePostMealMedicineAdder({Key? key, required this.medicationName})
      : super(key: key);

  @override
  State<PrePostMealMedicineAdder> createState() =>
      _PrePostMealMedicineAdderState();
}

class _PrePostMealMedicineAdderState extends State<PrePostMealMedicineAdder> {
  String? mealTiming;
  String? selectedMeal;
  String? beforeAfterTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('식전/식후 (택 1)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: _buildRadioRow(['식전', '식후'], mealTiming,
                    (val) => setState(() => mealTiming = val)),
              ),
              const SizedBox(height: 12),
              const Text('복용 시간 (중복 선택 불가)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: _buildRadioRow(['아침', '점심', '저녁'], selectedMeal,
                    (val) => setState(() => selectedMeal = val)),
              ),
              const SizedBox(height: 12),
              const Text('알림 시간 (택 1)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: _buildRadioRow(['30분', '1시간'], beforeAfterTime,
                    (val) => setState(() => beforeAfterTime = val)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicineTypeSelector()),
                  (route) => false,
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('닫기',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: (mealTiming != null &&
                        selectedMeal != null &&
                        beforeAfterTime != null)
                    ? () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MedicineTypeSelector()),
                          (route) => false,
                        )
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A50),
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('저장',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRadioRow(
      List<String> options, String? groupValue, ValueChanged<String> onChanged) {
    return options.map((option) {
      return Row(
        children: [
          Radio<String>(
            value: option,
            groupValue: groupValue,
            activeColor: Colors.deepOrange,
            onChanged: (val) => onChanged(val!),
          ),
          Text(option, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
        ],
      );
    }).toList();
  }
}
