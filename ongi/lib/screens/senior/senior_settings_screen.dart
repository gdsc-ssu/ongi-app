import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';
import 'package:ongi/screens/senior/senior_show_voice_screen.dart';
import 'package:ongi/screens/senior/senior_schedule_screen.dart';
import 'package:ongi/screens/senior/senior_home_alarm.dart';
import 'package:ongi/screens/senior/senior_home_default.dart';

class ElderSettingsScreen extends StatefulWidget {
  const ElderSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ElderSettingsScreen> createState() => _ElderSettingsScreenState();
}

class _ElderSettingsScreenState extends State<ElderSettingsScreen> {
  int _currentIndex = 2;

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ElderScheduleScreen()),
      );
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
      // 이미 설정
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  _buildProfileIcon(),
                  SizedBox(width: 16),
                  Text('Senior', style: TextStyle(fontSize: 22)),
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
                      Text('Caregiver', style: TextStyle(fontSize: 22)),
                      Text('Relationship', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              _buildMenuItem('Terms of Service', hasArrow: true),
              _buildMenuItem('Privacy Policy', hasArrow: true),
              _buildMenuItem('Log Out', hasArrow: true),
              _buildMenuItem('Delete Account', hasArrow: true),
              _buildMenuItem('Change Notification Voice', hasArrow: true, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ElderShowVoiceScreen()),
                );
              }),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Version', style: TextStyle(fontSize: 16)),
                  Text('1.0.0', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
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
            Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
            if (hasArrow)
              Icon(Icons.chevron_right, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
