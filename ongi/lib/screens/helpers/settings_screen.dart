import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/helpers/home_screen.dart';
import 'package:ongi/screens/helpers/alarm_screen.dart';
import 'package:ongi/screens/helpers/schedule_screen.dart';

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
          _buildMenuItem('Log Out'),
          _buildMenuItem('Delete Account'),
          _buildMenuItem('Change Notification Voice', onTap: () => setState(() => showVoiceScreen = true)),
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
    );
  }

  Widget _buildVoiceScreen() {
    return SingleChildScrollView(
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
          _buildVoiceMenuItem('Re-record Caregiver’s Voice', hasArrow: true),
          _buildVoiceMenuItem('Add Caregiver’s Voice', hasArrow: true),
          _buildVoiceMenuItem('Delete Caregiver’s Voice', hasArrow: true),
          _buildVoiceMenuItem('Add Custom Voice Alert Message', hasArrow: true),
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
          Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
          if (hasArrow)
            Icon(Icons.chevron_right, color: Colors.black, size: 22),
        ],
      ),
    );
  }
}
