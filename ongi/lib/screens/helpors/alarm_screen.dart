import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_with_alarm.dart';
import 'package:ongi/screens/helpors/home_screen.dart';
import 'package:ongi/screens/helpors/schedule_screen.dart';
import 'package:ongi/screens/helpors/settings_screen.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int _currentIndex = 1;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<bool>> dayStatus = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    DateTime lastDay = DateTime(2025, 5, 31);
    for (int i = 0; i < lastDay.day; i++) {
      DateTime currentDate = DateTime(2025, 5, i + 1);
      List<bool> status = List.filled(7, true);
      if (currentDate.day == 1) status[3] = false;
      else if (currentDate.day == 6) {
        status[1] = false;
        status[4] = false;
      } else if (currentDate.day == 11 || currentDate.day == 15) {
        status[0] = false;
      } else if (currentDate.day == 20) {
        status[4] = false;
      } else if (currentDate.day == 23) {
        status[1] = false;
        status[5] = false;
      } else if (currentDate.day == 28) {
        status[6] = false;
      }
      dayStatus[currentDate] = status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('온기, Ongi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '님의 알림 내역이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                child: Text('지난 알림을 확인해보세요.', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 357,
                  height: 519,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: const Offset(0, 10),
                        blurRadius: 60,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, color: Color(0xFFFF8A4D), size: 32),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                              });
                            },
                          ),
                          Text('${_focusedDay.month}월 ${_focusedDay.year}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, color: Color(0xFFFF8A4D), size: 32),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                              });
                            },
                          ),
                        ],
                      ),
                      TableCalendar(
                        firstDay: DateTime(_focusedDay.year, _focusedDay.month, 1),
                        lastDay: DateTime(_focusedDay.year, _focusedDay.month + 1, 0),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                          });
                        },
                        headerVisible: false,
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) => _buildDayCell(day),
                          todayBuilder: (context, day, focusedDay) => _buildDayCell(day, isToday: true),
                          selectedBuilder: (context, day, focusedDay) => _buildDayCell(day, isSelected: true),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
                          weekendStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: const BoxDecoration(color: Color(0xFFFF8A4D), shape: BoxShape.circle),
                          selectedDecoration: const BoxDecoration(color: Color(0xFFFF8A4D), shape: BoxShape.circle),
                          todayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWithAlarm(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }
        },
      ),
    );
  }

  Widget _buildDayCell(DateTime day, {bool isToday = false, bool isSelected = false}) {
    final status = dayStatus[day];
    bool showRice = false;
    bool showPill = false;
    if (status != null) {
      showRice = status.sublist(0, 3).contains(false);
      showPill = status.sublist(3).contains(false);
    }

    return Container(
      width: 44,
      height: 64,
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${day.day}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showPill) Image.asset('assets/icons/pill.png', width: 20, height: 20),
              if (showRice) Image.asset('assets/icons/rice.png', width: 20, height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
