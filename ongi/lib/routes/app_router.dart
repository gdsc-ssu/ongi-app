import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/helpors/home_screen.dart';
import '../screens/helpors/alarm_screen.dart';
import '../screens/helpors/schedule_screen.dart';
import '../screens/helpors/settings_screen.dart';
import '../screens/helpors/emergency_alert_screen.dart';
import '../screens/senior/senior_home_alarm.dart';




final GoRouter router = GoRouter(
  initialLocation: '/guardian-home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/guardian-home',
          name: 'guardian_home',
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
