import 'package:flutter/material.dart';
import 'package:ongi/state/account_type.dart';
import 'package:go_router/go_router.dart';

class AccountSelectScreen extends StatelessWidget {
  const AccountSelectScreen({super.key});

  void _selectAccount(BuildContext context, String type) {
    if (!hasCompletedSignUp) {
      context.go('/login');
      return;
    }

    selectedAccountType = type;
    restartApp?.call(); // main.dart의 라우터를 교체해서 홈화면으로 진입
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text('온기, Ongi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('사용자 계정을 선택해주세요.', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _selectAccount(context, 'helper'),
                            child: const Text('보호자 계정'),
                          ),
                        ],
                      ),
                      const SizedBox(width: 32),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(radius: 40, child: Icon(Icons.elderly, size: 40)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _selectAccount(context, 'senior'),
                            child: const Text('어르신 계정'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
