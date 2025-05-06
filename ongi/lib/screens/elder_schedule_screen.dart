import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';
import 'package:ongi/screens/elder_home_alarm.dart';
import 'package:ongi/screens/elder_home_default.dart';
import 'package:ongi/screens/elder_settings_screen.dart';

class ElderScheduleScreen extends StatefulWidget {
  const ElderScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ElderScheduleScreen> createState() => _ElderScheduleScreenState();
}

class _ElderScheduleScreenState extends State<ElderScheduleScreen> {
  int _currentIndex = 0;
  DateTime selectedDate = DateTime(2025, 1, 6);
  List<bool> mealChecked = [true, true, true];
  List<bool> medicineChecked = [true, true, true, true];

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      // 이미 스케줄
    } else if (index == 1) {
      if (ElderHomeAlarm.isDefaultHome) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ElderHomeDefault()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ElderHomeAlarm()),
        );
      }
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ElderSettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black26, width: 2),
                    ),
                    child: Text(
                      '${selectedDate.year}. ${selectedDate.month.toString().padLeft(2, '0')}. ${selectedDate.day.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
                    child: Text('식사', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          _buildCheckRow('아침식사', '08:00', 0, mealChecked, (val) {
                            setState(() => mealChecked[0] = val);
                          }),
                          _buildCheckRow('점심식사', '08:00', 1, mealChecked, (val) {
                            setState(() => mealChecked[1] = val);
                          }),
                          _buildCheckRow('저녁식사', '08:00', 2, mealChecked, (val) {
                            setState(() => mealChecked[2] = val);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('약', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          _buildCheckRow('감기약', '08:30', 0, medicineChecked, (val) {
                            setState(() => medicineChecked[0] = val);
                          }),
                          _buildCheckRow('혈압약', '10:00', 1, medicineChecked, (val) {
                            setState(() => medicineChecked[1] = val);
                          }),
                          _buildCheckRow('감기약', '12:30', 2, medicineChecked, (val) {
                            setState(() => medicineChecked[2] = val);
                          }),
                          _buildCheckRow('감기약', '17:30', 3, medicineChecked, (val) {
                            setState(() => medicineChecked[3] = val);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarSimple(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildCheckRow(String title, String time, int idx, List<bool> checkedList, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(!checkedList[idx]),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: checkedList[idx] ? Color(0xFFFF8A4D) : Colors.white,
                border: Border.all(color: Color(0xFFFF8A4D), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: checkedList[idx]
                  ? Icon(Icons.check, color: Colors.white, size: 24)
                  : null,
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
