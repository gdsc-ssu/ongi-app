import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/widgets/bottom_nav_bar/bottom_nav_bar_simple.dart';

import 'package:ongi/screens/senior/senior_home_alarm.dart';
import 'package:ongi/screens/senior/senior_home_default.dart';
import 'package:ongi/screens/senior/senior_schedule_screen.dart';
import 'package:ongi/screens/senior/senior_settings_screen.dart';
import 'package:ongi/screens/senior/senior_show_voice_screen.dart';

final GoRouter seniorRouter = GoRouter(
  initialLocation: '/senior-home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
  final location = state.uri.toString(); // 👈 이 방식으로 경로를 얻는다.
  int currentIndex = _getIndexByLocation(location);
  return Scaffold(
    body: child,
    bottomNavigationBar: BottomNavBarSimple(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/senior-schedule');
            break;
          case 1:
            context.go('/senior-home');
            break;
          case 2:
            context.go('/senior-settings');
            break;
        }
      },
    ),
  );
},

      routes: [
        GoRoute(
          path: '/senior-home',
          builder: (context, state) => ElderHomeAlarm(),
        ),
        GoRoute(
          path: '/senior-schedule',
          builder: (context, state) => ElderScheduleScreen(),
        ),
        GoRoute(
          path: '/senior-settings',
          builder: (context, state) => ElderSettingsScreen(),
        ),
        GoRoute(
        path: '/senior-home-default',
        builder: (context, state) => const ElderHomeDefault(),
),

      ],
    ),
  ],
);

int _getIndexByLocation(String location) {
  if (location.contains('schedule')) return 0;
  if (location.contains('settings')) return 2;
  return 1;
}
