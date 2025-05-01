import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/alarm_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/alarm/:id',
      name: 'alarm',
      builder: (context, state) {
        final alarmId = state.pathParameters['id'];
        return AlarmScreen(alarmId: alarmId);
      },
    ),
  ],
);