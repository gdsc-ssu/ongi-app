import 'package:flutter/material.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';
import 'package:ongi/screens/senior/senior_schedule_screen.dart';
import 'package:ongi/screens/senior/senior_settings_screen.dart';
import 'package:ongi/screens/senior/senior_home_alarm.dart';

class ElderHomeDefault extends StatefulWidget {
  const ElderHomeDefault({Key? key}) : super(key: key);

  @override
  State<ElderHomeDefault> createState() => _ElderHomeDefaultState();
}

class _ElderHomeDefaultState extends State<ElderHomeDefault> {
  int _currentIndex = 1;

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ElderScheduleScreen()),
      );
    } else if (index == 1) {
      if (ElderHomeAlarm.isDefaultHome) {
        // 이미 홈
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('2025. 01. 30', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'John Doe', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 20)),
                    TextSpan(text: 'Schedule', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Wishing you a warm and pleasant day.', style: TextStyle(color: Colors.grey, fontSize: 15)),
            ),
            SizedBox(height: 32),
            Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black12, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Your meal reminder\nis about to ring.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 26)),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('18:00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black12),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Confirm', style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black12),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Next Time', style: TextStyle(fontSize: 20, color: Colors.black38, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      
    );
  }
}
