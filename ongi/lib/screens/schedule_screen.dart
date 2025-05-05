import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';
import 'package:intl/intl.dart';
import 'package:ongi/screens/home_screen.dart';
import 'package:ongi/screens/alarm_screen.dart';
import 'package:ongi/screens/settings_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _Meal {
  String name;
  TimeOfDay time;
  _Meal(this.name, this.time);
}

class _Medicine {
  String name;
  List<TimeOfDay> times;
  _Medicine(this.name, this.times);
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _currentIndex = 2;
  List<_Meal> meals = [
    _Meal('점심식사', TimeOfDay(hour: 12, minute: 30)),
    _Meal('저녁식사', TimeOfDay(hour: 18, minute: 30)),
  ];
  List<_Medicine> medicines = [
    _Medicine('혈압약', [TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 21, minute: 0)]),
    _Medicine('감기약', []),
  ];

  void _addMeal() async {
    final result = await showDialog<_Meal>(
      context: context,
      builder: (context) => _MealTimeDialog(),
    );
    if (result != null) {
      setState(() {
        meals.add(result);
      });
    }
  }

  void _addMedicine() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicineTypeSelector()),
    );
    // 실제로는 추가된 약 정보를 받아와야 함 (여기선 예시)
    // setState(() { medicines.add(_Medicine('새 약', [TimeOfDay(hour: 8, minute: 0)])); });
  }

  String _formatTime(TimeOfDay t) => t.format(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text('온기, Ongi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '님의 스케줄이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                ),
                Text('지난 알림을 확인해보세요.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('식사', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: _addMeal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF8A4D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ...meals.map((meal) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
                  ),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: meal.name + ' ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                          TextSpan(text: _formatTime(meal.time), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)),
                        ],
                      ),
                    ),
                    trailing: Text('변경', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                )),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('약', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: _addMedicine,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF8A4D),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ...medicines.map((med) => Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(med.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            Text('변경', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        if (med.times.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: med.times.map((t) => ListTile(
                                leading: Icon(Icons.access_time, color: Colors.black),
                                title: Text(_formatTime(t), style: TextStyle(fontSize: 18)),
                              )).toList(),
                            ),
                          ),
                        if (med.times.isEmpty)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 8,
                              children: [
                                _buildCircle('식후'),
                                _buildCircle('30분'),
                                _buildCircle('아침'),
                                _buildCircle('점심'),
                                _buildCircle('저녁'),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AlarmScreen()),
            );
          } else if (index == 2) {
            // 이미 스케줄
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildCircle(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        shape: BoxShape.circle,
      ),
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
    );
  }
}

class _MealTimeDialog extends StatefulWidget {
  @override
  State<_MealTimeDialog> createState() => _MealTimeDialogState();
}

class _MealTimeDialogState extends State<_MealTimeDialog> {
  String mealName = '';
  TimeOfDay? mealTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('식사 시간 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(hintText: '식사 이름'),
            onChanged: (v) => mealName = v,
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(() => mealTime = picked);
            },
            child: Text(mealTime == null ? '시간 선택' : mealTime!.format(context)),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('취소'),
        ),
        ElevatedButton(
          onPressed: mealName.isNotEmpty && mealTime != null
              ? () => Navigator.pop(context, _Meal(mealName, mealTime!))
              : null,
          child: Text('추가'),
        ),
      ],
    );
  }
}
