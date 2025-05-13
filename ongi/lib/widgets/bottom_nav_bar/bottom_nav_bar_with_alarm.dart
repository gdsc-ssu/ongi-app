import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 이거 필수!

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
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/helpers-home');
            break;
          case 1:
            context.go('/alarm');
            break;
          case 2:
            context.go('/schedule');
            break;
          case 3:
            context.go('/settings');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFFF8A4D),
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
