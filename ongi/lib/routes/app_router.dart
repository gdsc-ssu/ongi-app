import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/Login/login_screen.dart';
import '../screens/Login/find_account_screen.dart';
import '../screens/Login/find_account_result_screen.dart';
import '../screens/SignUp/terms_screen.dart';
import '../screens/SignUp/signup_input_screen.dart';
import '../screens/SignUp/senior_info_screen.dart';
import '../screens/SignUp/meal_alert_screen.dart';
import '../screens/SignUp/medicine_schedule_screen.dart';
import '../screens/SignUp/alert_setting_screen.dart';
import '../screens/SignUp/voice_setting_screen.dart';
import '../screens/Splash/splash_screen.dart';
import '../screens/Splash/splash_loading_screen.dart';
import '../screens/Splash/account_select_screen.dart';

// 보호자용 화면
import '../screens/helpers/home_screen.dart';
import '../screens/helpers/alarm_screen.dart';

// 어르신용 화면
import '../screens/senior/senior_home_alarm.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // 보호자용 홈 화면
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/guardian-home',
      name: 'guardian_home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/senior-home',
      name: 'senior_home',
      builder: (context, state) => const ElderHomeAlarm(),
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
    GoRoute(
      path: '/signup/signup-input',
      name: 'signup-input',
      builder: (context, state) => const SignupInputScreen(),
    ),
    GoRoute(
      path: '/signup/senior-info',
      name: 'senior-info',
      builder: (context, state) => const SeniorInfoScreen(),
    ),
    GoRoute(
      path: '/signup/meal-alert',
      name: 'meal-alert',
      builder: (context, state) => const MealAlertScheduleScreen(),
    ),
    GoRoute(
      path: '/signup/medicine-schedule',
      name: 'medicine-schedule',
      builder: (context, state) => const MedicineScheduleScreen(),
    ),
    GoRoute(
      path: '/signup/alert-setting',
      name: 'alert-setting',
      builder: (context, state) => const AlertSettingScreen(),
    ),
    GoRoute(
      path: '/signup/voice-setting',
      name: 'voice-setting',
      builder: (context, state) => const VoiceSettingScreen(),
    ),

    // Splash
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/splash-loading',
      builder: (context, state) => const SplashLoadingScreen(),
    ),
    GoRoute(
      path: '/account-select',
      builder: (context, state) => const AccountSelectScreen(),
    ),
  ],
);
