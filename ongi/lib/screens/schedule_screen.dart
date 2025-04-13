import 'package:flutter/material.dart';
import 'package:ongi/components/bottom_nav_bar/bottom_nav_bar_simple.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('스케줄 화면')),
    Center(child: Text('홈 화면')),
    Center(child: Text('설정 화면')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBarSimple(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
