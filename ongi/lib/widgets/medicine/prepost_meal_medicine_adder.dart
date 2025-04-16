import 'package:flutter/material.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

class PrePostMealMedicineAdder extends StatefulWidget {
  final String medicationName;

  const PrePostMealMedicineAdder({Key? key, required this.medicationName})
      : super(key: key);

  @override
  State<PrePostMealMedicineAdder> createState() => _PrePostMealMedicineAdderState();
}

class _PrePostMealMedicineAdderState extends State<PrePostMealMedicineAdder> {
  String? mealTiming;
  String? selectedMeal;
  String? beforeAfterTime;

  List<Widget> _buildRadioRow(
    List<String> options,
    String? groupValue,
    ValueChanged<String> onChanged,
  ) {
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
          const SizedBox(width: 8),
        ],
      );
    }).toList();
  }

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
          width: MediaQuery.of(context).size.width * 0.85, // 가로폭 축소
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('약 이름', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(widget.medicationName),
              ),
              const SizedBox(height: 20),
              const Text('식전/식후 (택 1)', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(children: _buildRadioRow(['식전', '식후'], mealTiming, (val) => setState(() => mealTiming = val))),
              const SizedBox(height: 12),
              const Text('복용 시간 (택 1)', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(children: _buildRadioRow(['아침', '점심', '저녁'], selectedMeal, (val) => setState(() => selectedMeal = val))),
              const SizedBox(height: 12),
              const Text('알림 시간 (택 1)', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(children: _buildRadioRow(['30분', '1시간'], beforeAfterTime, (val) => setState(() => beforeAfterTime = val))),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MedicineTypeSelector()),
                          (route) => false,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('닫기', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (mealTiming != null && selectedMeal != null && beforeAfterTime != null)
                            ? () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MedicineTypeSelector()),
                                  (route) => false,
                                )
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A50),
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('저장'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
