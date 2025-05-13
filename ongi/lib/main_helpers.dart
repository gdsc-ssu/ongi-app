import 'package:flutter/material.dart';
import 'package:ongi/routes/helpers_router.dart'; // GoRouter 설정 파일
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: helpersRouter, // GoRouter 설정 연결
      title: 'Medication App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}
