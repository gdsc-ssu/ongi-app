import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MedicineTypeSelector(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.push('/alarm/1'),
                  child: const Text('알람으로 이동'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}