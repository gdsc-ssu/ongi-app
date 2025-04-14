import 'package:flutter/material.dart';

class BottomNavBarWithAlarm extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWithAlarm({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBarWithAlarm> createState() => _BottomNavBarWithAlarmState();
}

class _BottomNavBarWithAlarmState extends State<BottomNavBarWithAlarm> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFFF8A4D), // 주황색
      unselectedItemColor: Colors.black, // 검정색
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '알림',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: '스케줄',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }
}
