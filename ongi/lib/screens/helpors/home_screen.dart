import 'package:flutter/material.dart';
import 'package:ongi/screens/helpors/alarm_screen.dart';
import 'package:ongi/screens/helpors/schedule_screen.dart';
import 'package:ongi/screens/helpors/settings_screen.dart';
import 'package:ongi/screens/helpors/emergency_alert_screen.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<bool> mealChecked = [true, true, true];
  List<bool> medicineChecked = [true, true, true, true];

  bool get isEmergency {
    int unchecked = mealChecked.where((v) => !v).length + medicineChecked.where((v) => !v).length;
    return unchecked >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildTopBar(),
              const SizedBox(height: 16),
              _buildGreeting(),
              const SizedBox(height: 4), // 인삿말 아래 간격 줄이기
              const Text(
                '오늘도 따뜻한 하루 보내세요.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              if (isEmergency) _buildEmergencyBanner(), // 바로 아래에 배치
              const SizedBox(height: 16),
              _buildSectionTitle('  식사'),
              _buildCard([
                _buildCheckRow('아침식사', '08:00', 0, mealChecked, (val) => setState(() => mealChecked[0] = val)),
                _buildCheckRow('점심식사', '08:00', 1, mealChecked, (val) => setState(() => mealChecked[1] = val)),
                _buildCheckRow('저녁식사', '08:00', 2, mealChecked, (val) => setState(() => mealChecked[2] = val)),
              ]),
              const SizedBox(height: 16),
              _buildSectionTitle('  약'),
              _buildCard([
                _buildCheckRow('감기약', '08:30', 0, medicineChecked, (val) => setState(() => medicineChecked[0] = val)),
                _buildCheckRow('혈압약', '10:00', 1, medicineChecked, (val) => setState(() => medicineChecked[1] = val)),
                _buildCheckRow('감기약', '12:30', 2, medicineChecked, (val) => setState(() => medicineChecked[2] = val)),
                _buildCheckRow('감기약', '17:30', 3, medicineChecked, (val) => setState(() => medicineChecked[3] = val)),
              ]),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          switch (index) {
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AlarmScreen()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
              break;
          }
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '온기, Ongi   ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFBDBDBD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '2025. 01. 30',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const Icon(Icons.notifications_none, size: 32),
      ],
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0), // 간격 최소화
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
            TextSpan(text: '님의 일정이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF8A4D),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EmergencyAlertScreen())),
        child: const Center(
          child: Text(
            '긴급 상황 알림 발생',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // 내부 마진 확장
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
