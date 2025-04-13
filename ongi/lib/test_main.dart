import 'package:flutter/material.dart';
import 'package:ongi/components/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/components/bottom_nav_bar/bottom_nav_bar_simple.dart';

void main() {
  runApp(BottomNavBarTestApp());
}

class BottomNavBarTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNavBar Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestSelectionScreen(),
      // routes를 사용하는 대신 MaterialPageRoute로 화면 전환을 처리합니다.
    );
  }
}

class TestSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('테스트 메뉴')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // 버튼들을 화면 하단에 배치
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                // 4탭 하단바 테스트 화면으로 이동
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavWithAlarmScreen()),
                  );
                },
                child: Text('4탭 하단바 (Home/Alarm/Schedule/Settings)'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                // 3탭 하단바 테스트 화면으로 이동
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavSimpleScreen()),
                  );
                },
                child: Text('3탭 하단바 (Schedule/Home/Settings)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavWithAlarmScreen extends StatefulWidget {
  @override
  _BottomNavWithAlarmScreenState createState() => _BottomNavWithAlarmScreenState();
}

class _BottomNavWithAlarmScreenState extends State<BottomNavWithAlarmScreen> {
  int _selectedIndex = 0;
  // 각 탭에 대응하는 간단한 화면 위젯들 (Placeholder용)
  final List<Widget> _pages = [
    Center(child: Text('Home 화면')),
    Center(child: Text('Alarm 화면')),
    Center(child: Text('Schedule 화면')),
    Center(child: Text('Settings 화면')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4개 탭 BottomNavBar 테스트')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BottomNavSimpleScreen extends StatefulWidget {
  @override
  _BottomNavSimpleScreenState createState() => _BottomNavSimpleScreenState();
}

class _BottomNavSimpleScreenState extends State<BottomNavSimpleScreen> {
  int _selectedIndex = 0;
  // 각 탭에 대응하는 간단한 화면 위젯들 (Schedule/Home/Settings 순서)
  final List<Widget> _pages = [
    Center(child: Text('Schedule 화면')),
    Center(child: Text('Home 화면')),
    Center(child: Text('Settings 화면')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3개 탭 BottomNavBar 테스트')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBarSimple(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
