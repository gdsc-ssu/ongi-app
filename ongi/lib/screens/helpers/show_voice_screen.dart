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
                child: Text(
                  'Change Notification Voice',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 32),
              _buildVoiceMenuItem('Re-record Caregiver’s Voice', hasArrow: true),
              _buildVoiceMenuItem('Add Caregiver’s Voice', hasArrow: true),
              _buildVoiceMenuItem('Delete Caregiver’s Voice', hasArrow: true),
              _buildVoiceMenuItem('Add Custom Voice Alert Message', hasArrow: true),
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
          Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
          if (hasArrow)
            Icon(Icons.chevron_right, color: Colors.black, size: 22),
        ],
      ),
    );
  }
}
