import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/routes/senior_router.dart'; // senior 라우터로 연결
import 'package:ongi/routes/app_router.dart'; // app 라우터로 연결

void main() {
  runApp(const MySeniorApp());
}

class MySeniorApp extends StatelessWidget {
  const MySeniorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //routerConfig: seniorRouter,
      routerConfig: router,
      title: 'Senior App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}

