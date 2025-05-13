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
                    Text('Reason for Choosing "Later"', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                            title: Text('Not hungry'),
                          ),
                          RadioListTile<int>(
                            value: 1,
                            groupValue: reasonIdx,
                            onChanged: (v) => setState(() => reasonIdx = v),
                            title: Text('Busy with something else'),
                          ),
                          RadioListTile<int>(
                            value: 2,
                            groupValue: reasonIdx,
                            onChanged: (v) => setState(() => reasonIdx = v),
                            title: Text('Other'),
                          ),
                          if (reasonIdx == 2)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              child: TextField(
                                controller: etcController,
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  hintText: 'Please enter your reason.',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text('Would you like to be reminded again?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('In 30 minutes'),
                        ),
                        RadioListTile<int>(
                          value: 1,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('In 1 hour'),
                        ),
                        RadioListTile<int>(
                          value: 2,
                          groupValue: remindIdx,
                          onChanged: (v) => setState(() => remindIdx = v),
                          title: Text('No'),
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
                            child: Text('Cancel', style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: canSave
                                ? () {
                                    remind = remindIdx == 0
                                        ? '30 minutes'
                                        : remindIdx == 1
                                            ? '1 hour'
                                            : 'No';
                                    Navigator.of(context).pop();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF8A4D),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('Save', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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

    if (remind == '30 minutes' || remind == '1 hour') {
      final added = remind == '30 minutes' ? 30 : 60;
      final dt = DateTime(2025, 1, 30, alarmTime.hour, alarmTime.minute).add(Duration(minutes: added));
      setState(() {
        alarmTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
        _snoozed = true;
      });
    } else if (remind == 'No') {
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
                    TextSpan(text: 'John Doe', style: TextStyle(color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold, fontSize: 20)),
                    TextSpan(text: '님의 스케줄이에요.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
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
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8A4D),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text('Blood Pressure Medication', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                    SizedBox(height: 8),
                    Text('It’s time to take your medicine.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
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
                              ElderHomeAlarm.isDefaultHome = true;
                              context.go('/senior-home-default');
                            },

                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.white),
                            ),
                            child: Text('Confirm', style: TextStyle(fontSize: 20, color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold)),
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
                            child: Text('Next Time', style: TextStyle(fontSize: 20, color: Color(0xFFFF8A4D), fontWeight: FontWeight.bold)),
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
