import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        return Scaffold(body: child);
      },
      routes: [
        GoRoute(
          path: '/senior-home',
          name: 'senior_home',
          builder: (context, state) => const ElderHomeAlarm(),
        ),
        GoRoute(
          path: '/senior-home-default',
          name: 'senior_home_default',
          builder: (context, state) => const ElderHomeDefault(),
        ),
        GoRoute(
          path: '/senior-schedule',
          name: 'senior_schedule',
          builder: (context, state) => const ElderScheduleScreen(),
        ),
        GoRoute(
          path: '/senior-settings',
          name: 'senior_settings',
          builder: (context, state) => const ElderSettingsScreen(),
        ),
        GoRoute(
          path: '/senior-voice',
          name: 'senior_voice',
          builder: (context, state) => const ElderShowVoiceScreen(),
        ),
      ],
    ),
  ],
);
