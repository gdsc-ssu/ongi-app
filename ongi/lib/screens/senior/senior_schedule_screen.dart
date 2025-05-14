import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';
import 'package:ongi/screens/senior/senior_home_alarm.dart';
import 'package:ongi/screens/senior/senior_home_default.dart';
import 'package:ongi/screens/senior/senior_settings_screen.dart';

class ElderScheduleScreen extends StatefulWidget {
  const ElderScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ElderScheduleScreen> createState() => _ElderScheduleScreenState();
}

class _ElderScheduleScreenState extends State<ElderScheduleScreen> {
  int _currentIndex = 0;
  DateTime selectedDate = DateTime(2025, 5, 16);
  List<bool> mealChecked = [true, true, true];
  List<bool> medicineChecked = [true, true, true, true];

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) return;
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ElderHomeAlarm.isDefaultHome ? ElderHomeDefault() : ElderHomeAlarm()),
      );
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
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26, width: 2),
                  ),
                  child: Text(
                    '${selectedDate.year}. ${selectedDate.month.toString().padLeft(2, '0')}. ${selectedDate.day.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('Meal'),
              _buildCard([
                _buildCheckRow('Breakfast', '08:00', 0, mealChecked, (val) => setState(() => mealChecked[0] = val)),
                _buildCheckRow('Lunch', '12:00', 1, mealChecked, (val) => setState(() => mealChecked[1] = val)),
                _buildCheckRow('Dinner', '18:00', 2, mealChecked, (val) => setState(() => mealChecked[2] = val)),
              ]),

              const SizedBox(height: 24),
              _buildSectionTitle('Medication'),
              _buildCard([
                _buildCheckRow('Cold Medicine', '08:30', 0, medicineChecked, (val) => setState(() => medicineChecked[0] = val)),
                _buildCheckRow('Blood Pressure Medication', '10:00', 1, medicineChecked, (val) => setState(() => medicineChecked[1] = val)),
                _buildCheckRow('Cold Medicine', '12:30', 2, medicineChecked, (val) => setState(() => medicineChecked[2] = val)),
                _buildCheckRow('Cold Medicine', '17:30', 3, medicineChecked, (val) => setState(() => medicineChecked[3] = val)),
              ]),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
     
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('  $title', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.black26, width: 1),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildCheckRow(String title, String time, int index, List<bool> list, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(!list[index]),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: list[index] ? const Color(0xFFFF8A4D) : Colors.white,
                border: Border.all(color: const Color(0xFFFF8A4D), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: list[index]
                  ? const Icon(Icons.check, color: Colors.white, size: 24)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
