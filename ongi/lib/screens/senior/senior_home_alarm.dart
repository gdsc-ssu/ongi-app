import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';

class ElderHomeAlarm extends StatefulWidget {
  static bool isDefaultHome = false;
  const ElderHomeAlarm({Key? key}) : super(key: key);

  @override
  State<ElderHomeAlarm> createState() => _ElderHomeAlarmState();
}

class _ElderHomeAlarmState extends State<ElderHomeAlarm> {
  int _currentIndex = 1;
  TimeOfDay alarmTime = TimeOfDay(hour: 12, minute: 0);
  bool _snoozed = false;

  void _showNextReasonDialog() async {
    String? remind;
    int? reasonIdx;
    int? remindIdx;
    TextEditingController etcController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool canSave = reasonIdx != null && remindIdx != null && (reasonIdx != 2 || etcController.text.isNotEmpty);
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('다음에 누른 이유', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<int>(
                            value: 0,
                            groupValue: reasonIdx,
                            onChanged: (v) => setState(() => reasonIdx = v),
                            title: Text('배가 안 고픔'),
                          ),
                          RadioListTile<int>(
                            value: 1,
                            groupValue: reasonIdx,
                            onChanged: (v) => setState(() => reasonIdx = v),
                            title: Text('지금 할 일이 있음'),
                          ),
                          RadioListTile<int>(
                            value: 2,
                            groupValue: reasonIdx,
                            onChanged: (v) => setState(() => reasonIdx = v),
                            title: Text('기타'),
                          ),
                          if (reasonIdx == 2)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              child: TextField(
                                controller: etcController,
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  hintText: '이유를 입력하세요',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text('다시 알림을 드릴까요?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('30분 뒤'),
                        ),
                        RadioListTile<int>(
                          value: 1,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('1시간 뒤'),
                        ),
                        RadioListTile<int>(
                          value: 2,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('아니오.'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('취소', style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: canSave
                                ? () {
                                    remind = remindIdx == 0
                                        ? '30분'
                                        : remindIdx == 1
                                            ? '1시간'
                                            : '아니오';
                                    Navigator.of(context).pop();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF8A4D),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('저장', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (remind == '30분' || remind == '1시간') {
      final added = remind == '30분' ? 30 : 60;
      final dt = DateTime(2025, 1, 30, alarmTime.hour, alarmTime.minute).add(Duration(minutes: added));
      setState(() {
        alarmTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
        _snoozed = true;
      });
    } else if (remind == '아니오') {
      ElderHomeAlarm.isDefaultHome = true;
      context.go('/senior-home-default');
    }
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      context.go('/senior-schedule');
    } else if (index == 1) {
      if (!ElderHomeAlarm.isDefaultHome) return;
      context.go('/senior-home-default');
    } else if (index == 2) {
      context.go('/senior-settings');
    }
  }

  @override
  void initState() {
    super.initState();
    ElderHomeAlarm.isDefaultHome = false;
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
                    TextSpan(text: '홍길동', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 20)),
                    TextSpan(text: '님의 스케줄이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('오늘도 따뜻한 하루 보내세요.', style: TextStyle(color: Colors.grey, fontSize: 15)),
            ),
            SizedBox(height: 32),
            Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8A4D),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text('혈압 약', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(height: 8),
                    Text('드실 시간이에요', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        alarmTime.format(context),
                        style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              if (_snoozed) {
                                ElderHomeAlarm.isDefaultHome = true;
                                context.go('/senior-home-default');
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.white),
                            ),
                            child: Text('확인', style: TextStyle(fontSize: 20, color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _showNextReasonDialog,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.white),
                            ),
                            child: Text('다음에', style: TextStyle(fontSize: 20, color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold)),
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
