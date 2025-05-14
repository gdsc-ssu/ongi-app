import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';
import 'package:intl/intl.dart';
import 'package:ongi/screens/helpers/home_screen.dart';
import 'package:ongi/screens/helpers/alarm_screen.dart';
import 'package:ongi/screens/helpers/settings_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

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
    _Meal('Lunch  ', TimeOfDay(hour: 12, minute: 30)),
    _Meal('Dinner  ', TimeOfDay(hour: 18, minute: 30)),
  ];
  List<_Medicine> medicines = [
    _Medicine('Blood Pressure Medication', [TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 21, minute: 0)]),
    _Medicine('Cold Medicine', []),
  ];

  // 달력 날짜별 이모티콘 상태 (알약: 💊, 밥: 🍚)
  final Map<DateTime, List<String>> calendarIcons = {
    DateTime(2025, 5, 1): ['💊'],
    DateTime(2025, 5, 6): ['💊', '🍚'],
    DateTime(2025, 5, 11): ['🍚'],
    DateTime(2025, 5, 15): ['🍚'],
    DateTime(2025, 5, 20): ['💊'],
    DateTime(2025, 5, 23): ['💊', '🍚'],
    DateTime(2025, 5, 28): ['💊'],
  };

  void _addMeal() async {
    final result = await showDialog<_Meal>(
      context: context,
      builder: (context) => _MealTimeDialogV3(),
    );
    if (result != null) {
      _addMealSorted(result);
    }
  }

  void _addMedicine() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 32,
        ),
        child: Material(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: MedicineTypeSelector(
              onMedicineAdded: (medicine) {
                Navigator.pop(context);
                if (medicine['type'] == 'timed') {
                  setState(() {
                    medicines.add(_Medicine(
                      medicine['name'],
                      List<TimeOfDay>.from(medicine['times']),
                    ));
                  });
                } else if (medicine['type'] == 'prepost') {
                  setState(() {
                    medicines.add(_Medicine(medicine['name'], []));
                  });
                }
              },
            ),
          ),
        ),
      );
    },
  );
}

  String _formatTime(TimeOfDay t) => t.format(context);

  // Calendar
  Widget buildCalendarDayCell(DateTime day) {
    final icons = calendarIcons[DateTime(day.year, day.month, day.day)] ?? [];
    return Container(
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${day.day}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: icons.map((icon) {
              if (icon == '💊') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Image.asset('assets/icons/pill.png', width: 18, height: 18),
                );
              } else if (icon == '🍚') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Image.asset('assets/icons/rice.png', width: 18, height: 18),
                );
              } else {
                return SizedBox.shrink();
              }
            }).toList(),
          ),
        ],
      ),
    );
  }

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
                Text('Ongi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'John Doe', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 20)),
                      TextSpan(text: '  Schedule', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                Text('Check past notifications.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Meal', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
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
                   width: 340,
                  height: 60,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
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
                    trailing: Text('Change', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                )),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('Medication', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
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
    padding: const EdgeInsets.all(20), // ✅ 박스 내부 여백 20px
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(med.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Change', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        if (med.times.isNotEmpty)
          Container(
            width: double.infinity, // ✅ 시간 있는 약은 그대로
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.fromLTRB(10, 2, 2, 2),
            child: Column(
              children: med.times.map((t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  leading: Icon(Icons.access_time, color: Colors.black, size: 20),
                  title: Text(_formatTime(t), style: TextStyle(fontSize: 16)),
                ),
              )).toList(),
            ),
          ),
        if (med.times.isEmpty)
          Container(
            width: MediaQuery.of(context).size.width - 72,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildMiniIconWithLabel('After meal'),
                    _buildMiniIconWithLabel('30 minutes'),
                  ],
                ),
                SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildMiniIconWithLabel('Breakfast'),
                    _buildMiniIconWithLabel('Lunch'),
                    _buildMiniIconWithLabel('Dinner'),
                  ],
                ),
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

  Widget _buildMiniIconWithLabel(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[400], // 더 진한 회색
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black)), // 검정 텍스트
      ],
    ),
  );
}


  void _addMealSorted(_Meal meal) {
    setState(() {
      meals.add(meal);
      meals.sort((a, b) {
        final aMinutes = a.time.hour * 60 + a.time.minute;
        final bMinutes = b.time.hour * 60 + b.time.minute;
        return aMinutes.compareTo(bMinutes);
      });
    });
  }
}

class _MealTimeDialogV3 extends StatefulWidget {
  @override
  State<_MealTimeDialogV3> createState() => _MealTimeDialogV3State();
}

class _MealTimeDialogV3State extends State<_MealTimeDialogV3> {
  String mealName = '';
  TimeOfDay? mealTime;

  void _showTimerPicker() async {
    Duration tempDuration = const Duration(hours: 0, minutes: 0);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: const Duration(hours: 0, minutes: 0),
                  onTimerDurationChanged: (Duration newDuration) {
                    tempDuration = newDuration;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempDuration),
                      child: const Text('Confirm', style: TextStyle(color: Colors.deepOrange, fontSize: 16)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ).then((picked) {
      if (picked != null) {
        setState(() {
          mealTime = TimeOfDay(hour: picked.inHours, minute: picked.inMinutes.remainder(60));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meal name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
  decoration: InputDecoration(
    hintText: 'Input meal name',
    filled: true,
    fillColor: Color(0xFFE0E0E0), // 회색 배경 명시적으로 설정
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(15), // 굴곡 15
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(15), // 굴곡 15
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  onChanged: (v) => mealName = v,
),



            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showTimerPicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  elevation: 0,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(mealTime == null ? 'Select Time' : mealTime!.format(context), style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: mealName.isNotEmpty && mealTime != null
                        ? () => Navigator.pop(context, _Meal(mealName, mealTime!))
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A50),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicineAddDialog extends StatefulWidget {
  @override
  State<_MedicineAddDialog> createState() => _MedicineAddDialogState();
}

class _MedicineAddDialogState extends State<_MedicineAddDialog> {
  String medName = '';
  List<TimeOfDay> times = [];

  void _showTimerPicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        times.add(picked);
      });
    }
  }

  void _removeTime(TimeOfDay t) {
    setState(() {
      times.remove(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medication name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(hintText: 'Input medication name'),
              onChanged: (v) => medName = v,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showTimerPicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  elevation: 0,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Add Medication Time', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 12),
            ...times.map((t) => ListTile(
                  title: Text('${t.hour.toString().padLeft(2, '0')}Hour ${t.minute.toString().padLeft(2, '0')}Minute', style: TextStyle(fontSize: 16)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () => _removeTime(t),
                  ),
                )),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: medName.isNotEmpty && times.isNotEmpty
                        ? () => Navigator.pop(context, _Medicine(medName, times))
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A50),
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
