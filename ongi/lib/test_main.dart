import 'package:flutter/material.dart';
import 'screens/helpors/home_screen.dart'; // 또는 emergency_alert_screen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HomeScreen(), // ← 여기서 원하는 화면으로 설정
    );
  }
}
