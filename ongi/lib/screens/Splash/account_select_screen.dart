import 'package:flutter/material.dart';
import 'package:ongi/state/account_type.dart';
import 'package:go_router/go_router.dart';

class AccountSelectScreen extends StatelessWidget {
  const AccountSelectScreen({super.key});

  void _selectAccount(BuildContext context, String type) {
    if (!hasCompletedSignUp) {
      // ✅ 회원가입 아직 안 한 경우 → 회원가입 화면으로 이동
      context.go('/signup/terms');
      return;
    }

    // ✅ 회원가입 완료한 경우 → 홈화면 이동
    selectedAccountType = type;
    restartApp?.call();
  }

  Widget _buildAccountButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 60, // 크게 변경
          backgroundColor: const Color(0xFFFFE1D5),
          child: Icon(icon, size: 48, color: Colors.black), // 아이콘 크게
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF752B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // 버튼 크게
            textStyle: const TextStyle(fontSize: 18), // 텍스트 크기
          ),
          child: Text(label),
        ),
      ],
    );
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
              const Text('Ongi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Please select your account type.', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 32),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAccountButton(
                          icon: Icons.person,
                          label: 'Caregiver Account',
                          onTap: () => _selectAccount(context, 'helper'),
                        ),
                        const SizedBox(height: 32),
                        _buildAccountButton(
                          icon: Icons.elderly,
                          label: 'Senior Account',
                          onTap: () => _selectAccount(context, 'senior'),
                        ),
                      ],
                    ),
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
