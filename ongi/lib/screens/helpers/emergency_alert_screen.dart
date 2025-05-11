import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/helpers/home_screen.dart';
import 'package:ongi/screens/helpers/alarm_screen.dart';
import 'package:ongi/screens/helpers/schedule_screen.dart';
import 'package:ongi/screens/helpers/settings_screen.dart';

class EmergencyAlertScreen extends StatelessWidget {
  const EmergencyAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 상단 바
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text('긴급 알림 관리', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 32)),
              const SizedBox(height: 4),
              const Text('2025. 01. 30', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              const SizedBox(height: 32),

              // 식사
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0, bottom: 8.0),
                  child: Text('식사', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xB3FF752B), // #FF752B, 70% opacity
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_box_outline_blank, color: Colors.white, size: 32),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text('점심식사', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('08:00', style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

              // 약
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0, bottom: 8.0),
                  child: Text('약', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 32),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xB3FF752B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_box_outline_blank, color: Colors.white, size: 32),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('감기약', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text('12:30', style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.check_box_outline_blank, color: Colors.white, size: 32),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('감기약', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text('17:30', style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 응답 누락 횟수
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('응답 누락 횟수 3회', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),

              // 어르신과 연락하기
              const Text('어르신과 연락하기', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 26)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.phone, size: 38, color: Colors.black87),
                  ),
                  const SizedBox(width: 32),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mail, size: 38, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AlarmScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }
        },
      ),
    );
  }
}
