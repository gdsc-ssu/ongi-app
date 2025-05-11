import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/helpers/home_screen.dart';
import '../screens/helpers/alarm_screen.dart';
import '../screens/helpers/schedule_screen.dart';
import '../screens/helpers/settings_screen.dart';
import '../screens/helpers/emergency_alert_screen.dart';
import '../screens/senior/senior_home_alarm.dart';




final GoRouter router = GoRouter(
  initialLocation: '/helpers-home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/helpers-home',
          name: 'helpers_home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/alarm',
          name: 'alarm',
          builder: (context, state) => const AlarmScreen(),
        ),
        GoRoute(
          path: '/schedule',
          name: 'schedule',
          builder: (context, state) => const ScheduleScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/emergency',
      name: 'emergency',
      builder: (context, state) => const EmergencyAlertScreen(),
    ),
    GoRoute(
      path: '/senior-home',
      name: 'senior_home',
      builder: (context, state) => const ElderHomeAlarm(),
    ),
  ],
);
