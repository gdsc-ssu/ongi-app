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

  // 날짜별 체크박스 상태: [아침, 점심, 저녁, 감기약, 혈압약, 감기약, 감기약]
  Map<DateTime, List<bool>> dayStatus = {};

  List<String> mealTitles = ['아침식사', '점심식사', '저녁식사'];
  List<String> mealTimes = ['08:00', '08:00', '08:00'];
  List<String> medTitles = ['감기약', '혈압약', '감기약', '감기약'];
  List<String> medTimes = ['08:30', '10:00', '12:30', '17:30'];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // 2025년 5월의 모든 날짜에 대해 데이터 초기화
    DateTime lastDay = DateTime(2025, 5, 31);
    for (int i = 0; i < lastDay.day; i++) {
      DateTime currentDate = DateTime(2025, 5, i + 1);
      List<bool> status = List.filled(7, true);
      if (currentDate.day == 1) {
        status[3] = false; // 감기약 8:30만 false
      } else if (currentDate.day == 6) {
        status[1] = false; // 점심식사 false
        status[4] = false; // 혈압약 false
      } else if (currentDate.day == 11) {
        status[0] = false; // 아침식사 false
      } else if (currentDate.day == 15) {
        status[0] = false; // 아침식사 false
      } else if (currentDate.day == 20) {
        status[4] = false; // 혈압약 false
      } else if (currentDate.day == 23) {
        status[1] = false; // 점심식사 false
        status[5] = false; // 감기약 12:30 false
      } else if (currentDate.day == 28) {
        status[6] = false; // 감기약 17:30 false
      }
      dayStatus[currentDate] = status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('온기, Ongi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '님의 알림 내역이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                child: Text('지난 알림을 확인해보세요.', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left, color: Color(0xFFFF8A4D), size: 32),
                              onPressed: () {
                                setState(() {
                                  _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                                });
                              },
                            ),
                            Text('${_focusedDay.month}월 ${_focusedDay.year}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.chevron_right, color: Color(0xFFFF8A4D), size: 32),
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
                            print(selectedDay);
                            print(dayStatus[selectedDay]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlarmDetailScreen(
                                  day: selectedDay,
                                  status: dayStatus[selectedDay]!,
                                  onStatusChanged: (idx, val) {
                                    setState(() {
                                      dayStatus[selectedDay]![idx] = val;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (context, day, focusedDay) {
                              return _buildDayCell(day);
                            },
                            todayBuilder: (context, day, focusedDay) {
                              return _buildDayCell(day, isToday: true);
                            },
                            selectedBuilder: (context, day, focusedDay) {
                              return _buildDayCell(day, isSelected: true);
                            },
                          ),
                          headerVisible: false,
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
                          ),
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            todayDecoration: BoxDecoration(
                              color: Color(0xFFFF8A4D),
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Color(0xFFFF8A4D),
                              shape: BoxShape.circle,
                            ),
                            todayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            selectedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
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
            // 이미 알림
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

  Widget _buildDayCell(DateTime day, {bool isToday = false, bool isSelected = false}) {
    final status = dayStatus[day];
    bool showRice = false;
    bool showPill = false;
    if (status != null) {
      showRice = status.sublist(0, 3).contains(false);
      showPill = status.sublist(3).contains(false);
    }
    return Container(
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${day.day}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showPill) Image.asset('assets/icons/pill.png', width: 24, height: 24),
              if (showRice) Image.asset('assets/icons/rice.png', width: 24, height: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class AlarmDetailScreen extends StatefulWidget {
  final DateTime day;
  final List<bool> status;
  final Function(int, bool) onStatusChanged;
  const AlarmDetailScreen({Key? key, required this.day, required this.status, required this.onStatusChanged}) : super(key: key);

  @override
  State<AlarmDetailScreen> createState() => _AlarmDetailScreenState();
}

class _AlarmDetailScreenState extends State<AlarmDetailScreen> {
  late List<bool> localStatus;
  List<String> mealTitles = ['아침식사', '점심식사', '저녁식사'];
  List<String> mealTimes = ['08:00', '08:00', '08:00'];
  List<String> medTitles = ['감기약', '혈압약', '감기약', '감기약'];
  List<String> medTimes = ['08:30', '10:00', '12:30', '17:30'];

  @override
  void initState() {
    super.initState();
    localStatus = List.from(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                        SizedBox(width: 2),
                        Text('이전', style: TextStyle(fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8A4D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widget.day.year}. ${widget.day.month.toString().padLeft(2, '0')}. ${widget.day.day.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text('식사', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      ...List.generate(3, (i) => _buildCheckRow(mealTitles[i], mealTimes[i], i)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text('약', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      ...List.generate(4, (i) => _buildCheckRow(medTitles[i], medTimes[i], i + 3)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckRow(String title, String time, int idx) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Checkbox(
            value: localStatus[idx],
            activeColor: Color(0xFFFF8A4D),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onChanged: (val) {
              setState(() {
                localStatus[idx] = val ?? false;
                widget.onStatusChanged(idx, val ?? false);
              });
            },
          ),
          SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
