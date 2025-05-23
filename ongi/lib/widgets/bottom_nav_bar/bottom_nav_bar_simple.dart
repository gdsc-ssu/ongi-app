import 'package:flutter/material.dart';

class BottomNavBarSimple extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarSimple({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBarSimple> createState() => _BottomNavBarSimpleState();
}

class _BottomNavBarSimpleState extends State<BottomNavBarSimple> {
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
          icon: Icon(Icons.menu, size: 36),
          label: '스케줄',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 36),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 36),
          label: '설정',
        ),
      ],
      selectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}