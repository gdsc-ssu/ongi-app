import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FindAccountScreen extends StatelessWidget {
  const FindAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final codeController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Find ID/Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              const Text('Phone Number'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Please enter your phone number.',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Get Verification Code'),
                  )
                ],
              ),
              const SizedBox(height: 20),

              const Text('	Enter Verification Code	'),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  hintText: 'Please enter the verification code.',
                ),
              ),
              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/find-account-result');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFAE87),
                      ),
                      child: const Text('Next'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
