import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/helpors/home_screen.dart';
import 'package:ongi/screens/helpors/alarm_screen.dart';
import 'package:ongi/screens/helpors/schedule_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 3;
  bool showVoiceScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: showVoiceScreen ? _buildVoiceScreen() : _buildSettingsScreen(),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScheduleScreen()),
            );
          } else if (index == 3) {
            // 이미 설정
          }
        },
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              _buildProfileIcon(),
              SizedBox(width: 16),
              Text('어르신', style: TextStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              _buildProfileIcon(),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('보호자', style: TextStyle(fontSize: 22)),
                  Text('관계', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          _buildMenuItem('서비스이용약관', hasArrow: true),
          _buildMenuItem('개인정보처리방침', hasArrow: true),
          _buildMenuItem('로그아웃'),
          _buildMenuItem('회원탈퇴'),
          _buildMenuItem('알림 음성 변경', onTap: () => setState(() => showVoiceScreen = true)),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('버전', style: TextStyle(fontSize: 16)),
              Text('1.0.0', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildVoiceScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => showVoiceScreen = false),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                    SizedBox(width: 2),
                    Text('이전', style: TextStyle(fontSize: 18, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Center(
            child: Text('알림 음성 변경', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 32),
          _buildVoiceMenuItem('보호자 음성 재녹음', hasArrow: true),
          _buildVoiceMenuItem('보호자 음성 추가', hasArrow: true),
          _buildVoiceMenuItem('보호자 음성 삭제'),
          _buildVoiceMenuItem('추가 음성 알림 문구 등록'),
        ],
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFFBDBDBD),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, size: 40, color: Colors.black),
    );
  }

  Widget _buildMenuItem(String title, {bool hasArrow = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFF888888),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(width: 16),
            Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
            if (hasArrow)
              Icon(Icons.chevron_right, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceMenuItem(String title, {bool hasArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(0xFF888888),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(width: 16),
          Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
          if (hasArrow)
            Icon(Icons.chevron_right, color: Colors.black, size: 22),
        ],
      ),
    );
  }
}
