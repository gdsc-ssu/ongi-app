import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  final String? alarmId;
  
  const AlarmScreen({
    super.key,
    this.alarmId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알람')),
      body: Center(
        child: Text(alarmId != null ? '알람 ID: $alarmId' : '알람 ID가 없습니다'),
      ),
    );
  }
}