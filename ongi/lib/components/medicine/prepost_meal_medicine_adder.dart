import 'package:flutter/material.dart';

class PrePostMealMedicineAdder extends StatefulWidget {
  final String medicineName;

  const PrePostMealMedicineAdder({super.key, required this.medicineName});

  @override
  State<PrePostMealMedicineAdder> createState() => _PrePostMealMedicineAdderState();
}

class _PrePostMealMedicineAdderState extends State<PrePostMealMedicineAdder> {
  String? _mealTiming; // '식전' or '식후'
  final Set<String> _mealTimes = {}; // '아침', '점심', '저녁'
  String? _alertTiming; // '30분' or '1시간'

  void _toggleMealTime(String meal) {
    setState(() {
      if (_mealTimes.contains(meal)) {
        _mealTimes.remove(meal);
      } else {
        _mealTimes.add(meal);
      }
    });
  }

  bool get _isValid {
    return _mealTiming != null && _mealTimes.isNotEmpty && _alertTiming != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.medicineName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              const Text('약 정보 (택 1)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: ['식전', '식후'].map((option) {
                  return Expanded(
                    child: RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _mealTiming,
                      onChanged: (value) {
                        setState(() {
                          _mealTiming = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              const Text('복용 시간 (중복 선택 가능)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: ['아침', '점심', '저녁'].map((meal) {
                  return FilterChip(
                    label: Text(meal),
                    selected: _mealTimes.contains(meal),
                    onSelected: (_) => _toggleMealTime(meal),
                    selectedColor: const Color(0xFFFFE0D1),
                    checkmarkColor: Colors.deepOrange,
                    backgroundColor: const Color(0xFFF2F2F2),
                    labelStyle: TextStyle(
                      color: _mealTimes.contains(meal) ? Colors.deepOrange : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              const Text('알림 시간 (택 1)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: ['30분', '1시간'].map((option) {
                  return Expanded(
                    child: RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _alertTiming,
                      onChanged: (value) {
                        setState(() {
                          _alertTiming = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text('닫기', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isValid ? () {
                        // 저장 로직
                      } : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: const Text('저장', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
