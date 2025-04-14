import 'package:flutter/material.dart';

class PrePostMealMedicineAdder extends StatefulWidget {
  final String medicationName;

  const PrePostMealMedicineAdder({Key? key, required this.medicationName}) : super(key: key);

  @override
  State<PrePostMealMedicineAdder> createState() => _PrePostMealMedicineAdderState();
}

class _PrePostMealMedicineAdderState extends State<PrePostMealMedicineAdder> {
  String? mealTiming; // 식전 or 식후
  List<String> selectedMeals = []; // 아침, 점심, 저녁
  String? beforeAfterTime; // 30분 or 1시간

  void toggleMeal(String meal) {
    setState(() {
      if (selectedMeals.contains(meal)) {
        selectedMeals.remove(meal);
      } else {
        selectedMeals.add(meal);
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '식전/식후 (택 1)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectButton('식전', mealTiming == '식전', () {
                  setState(() => mealTiming = '식전');
                }),
                _buildSelectButton('식후', mealTiming == '식후', () {
                  setState(() => mealTiming = '식후');
                }),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              '복용 시간 (중복 선택 가능)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectButton('아침', selectedMeals.contains('아침'), () => toggleMeal('아침')),
                _buildSelectButton('점심', selectedMeals.contains('점심'), () => toggleMeal('점심')),
                _buildSelectButton('저녁', selectedMeals.contains('저녁'), () => toggleMeal('저녁')),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              '알림 시간 (택 1)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectButton('30분', beforeAfterTime == '30분', () {
                  setState(() => beforeAfterTime = '30분');
                }),
                _buildSelectButton('1시간', beforeAfterTime == '1시간', () {
                  setState(() => beforeAfterTime = '1시간');
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('닫기', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: (mealTiming != null && selectedMeals.isNotEmpty && beforeAfterTime != null)
                    ? () {}
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A50),
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('저장', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton(String label, bool selected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? const Color(0xFFFF8A50) : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.black,
        elevation: 0,
        side: BorderSide(color: selected ? Colors.deepOrange : Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Text(label, style: const TextStyle(fontSize: 18)),
    );
  }
}
