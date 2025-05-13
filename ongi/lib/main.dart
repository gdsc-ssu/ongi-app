import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/routes/app_router.dart';
import 'package:ongi/routes/helpers_router.dart';
import 'package:ongi/routes/senior_router.dart';
import 'package:ongi/state/account_type.dart';
import 'package:provider/provider.dart';
import 'models/signup_form_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SignUpFormModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = _createRouter();
    restartApp = () => setState(() {
          _router = _createRouter();
        });
  }

  GoRouter _createRouter() {
    return switch (selectedAccountType) {
      'helper' => helpersRouter,
      'senior' => seniorRouter,
      _ => appRouter,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Ongi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
    );
  }
}