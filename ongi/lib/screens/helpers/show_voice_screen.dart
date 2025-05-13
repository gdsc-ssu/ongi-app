import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/helpers/home_screen.dart';
import 'package:ongi/screens/helpers/alarm_screen.dart';
import 'package:ongi/screens/helpers/schedule_screen.dart';
import 'package:ongi/screens/helpers/settings_screen.dart';

class ShowVoiceScreen extends StatelessWidget {
  const ShowVoiceScreen({Key? key}) : super(key: key);

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
              SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                        SizedBox(width: 2),
                        Text('Back', style: TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: Text('Change Notification Voice', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 32),
              _buildVoiceMenuItem('Re-record Guardian’s Voice', hasArrow: true),
              _buildVoiceMenuItem('Add Guardian’s Voice', hasArrow: true),
              _buildVoiceMenuItem('Delete Guardian’s Voice'),
              _buildVoiceMenuItem('Add Custom Voice Alert Message'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: 3,
        onTap: (index) {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
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