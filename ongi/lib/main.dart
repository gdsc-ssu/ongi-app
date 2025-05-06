import 'package:flutter/material.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';
import 'package:ongi/screens/home_screen.dart';
import 'package:ongi/screens/elder_home_alarm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ElderHomeAlarm(),
    );
  }
}