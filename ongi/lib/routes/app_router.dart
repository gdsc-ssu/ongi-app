import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 보호자용 화면
import '../screens/helpors/home_screen.dart';
import '../screens/helpors/alarm_screen.dart';

// 어르신용 화면
import '../screens/senior/senior_home_alarm.dart';

final GoRouter router = GoRouter(
  routes: [
    // 보호자용 홈 화면
    GoRoute(
      path: '/guardian-home',
      name: 'guardian_home',
      builder: (context, state) => const HomeScreen(),
    ),

    // 어르신용 홈 화면
    GoRoute(
      path: '/senior-home',
      name: 'senior_home',
      builder: (context, state) => const ElderHomeAlarm(),
    ),

  ],
);
