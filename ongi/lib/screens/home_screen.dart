import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/emergency_alert_screen.dart';
import 'package:ongi/screens/alarm_screen.dart';
import 'package:ongi/screens/schedule_screen.dart';
import 'package:ongi/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 각 식사/약 항목별 체크 상태 관리
  List<bool> mealChecked = [true, true, true];
  List<bool> medicineChecked = [true, true, true, true];

  bool get isEmergency {
    int unchecked = mealChecked.where((v) => !v).length + medicineChecked.where((v) => !v).length;
    return unchecked >= 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단바 및 날짜/알림
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('온기, Ongi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFBDBDBD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('2025. 01. 30', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Icon(Icons.notifications_none, size: 32),
                    ],
                  ),
                ),
                // 인사 및 안내
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 4.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                        TextSpan(text: '님의 일정이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, bottom: 16.0),
                  child: Text('오늘도 따뜻한 하루 보내세요.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                // 식사 카드
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('식사', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      SizedBox(height: 8),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Column(
                            children: [
                              _buildMealRow('아침식사', '08:00', 0),
                              _buildMealRow('점심식사', '08:00', 1),
                              _buildMealRow('저녁식사', '08:00', 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 약 카드
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('약', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      SizedBox(height: 8),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Column(
                            children: [
                              _buildMedicineRow('감기약', '08:30', 0),
                              _buildMedicineRow('혈압약', '10:00', 1),
                              _buildMedicineRow('감기약', '12:30', 2),
                              _buildMedicineRow('감기약', '17:30', 3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            // 긴급 상황 알림 배너
            AnimatedOpacity(
              opacity: isEmergency ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: isEmergency
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmergencyAlertScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF8A4D),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            '긴급 상황 알림 발생',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          if (index == 0) {
            // 이미 홈
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AlarmScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScheduleScreen()),
            );
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

  Widget _buildMealRow(String title, String time, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Checkbox(
            value: mealChecked[idx],
            activeColor: Color(0xFFFF8A4D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onChanged: (val) {
              setState(() {
                mealChecked[idx] = val ?? false;
              });
            },
          ),
          SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
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

  Widget _buildMedicineRow(String title, String time, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Checkbox(
            value: medicineChecked[idx],
            activeColor: Color(0xFFFF8A4D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onChanged: (val) {
              setState(() {
                medicineChecked[idx] = val ?? false;
              });
            },
          ),
          SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
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
