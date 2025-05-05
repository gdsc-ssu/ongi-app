import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/alarm_screen.dart';
import '../screens/Login/login_screen.dart';
import '../screens/Login/find_account_screen.dart';
import '../screens/Login/find_account_result_screen.dart';
import '../screens/SignUp/terms_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
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
    GoRoute(
      path: '/find-account',
      name: 'find-account',
      builder: (context, state) => const FindAccountScreen(),
    ),
    GoRoute(
      path: '/find-account-result',
      name: 'find-account-result',
      builder: (context, state) => const FindAccountResultScreen(),
    ),
    GoRoute(
      path: '/signup/terms',
      name: 'terms',
      builder: (context, state) => const TermsScreen(),
    ),
  ],
);