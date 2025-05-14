import 'package:flutter/material.dart';
import 'package:ongi/state/account_type.dart';
import 'package:go_router/go_router.dart';

class AccountSelectScreen extends StatelessWidget {
  const AccountSelectScreen({super.key});

  void _selectAccount(BuildContext context, String type) {
    if (!hasCompletedSignUp) {
      // ✅ 회원가입 아직 안 한 경우 → 회원가입 화면으로 이동
      context.go('/signup/terms'); // ← 첫 회원가입 경로로 맞춰주세요
      return;
    }

    // ✅ 회원가입 완료한 경우 → 홈화면 이동
    selectedAccountType = type;
    restartApp?.call(); // main.dart의 라우터를 교체해서 홈화면으로 진입
  }

  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// Builds the account select screen, which prompts the user to select their
  /// account type (caregiver or senior).
  ///
  /// The screen displays a heading with the app name, a message asking the user
  /// to select their account type, and two buttons representing the two account
  /// types. The buttons are horizontally centered and equally spaced.
  ///
  /// When the user taps on a button, the [_selectAccount] function is called
  /// with the corresponding account type. This function checks if the user has
  /// completed the sign-up process. If not, it navigates to the sign-up screen.
  /// If the user has completed the sign-up process, it updates the selected
  /// account type in the app state and restarts the app.
/*******  28e9dc1c-0e5b-4083-a82b-dddc3856c1c7  *******/  Widget _buildAccountButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: const Color(0xFFFFE1D5),
        child: Icon(icon, size: 40, color: Colors.black),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF752B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        child: Text(label),
      ),
    ],
  );
}



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
              const SizedBox(height: 12),
              Expanded(
  child: Center(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAccountButton(
            icon: Icons.person,
            label: 'Caregiver Account',
            onTap: () => _selectAccount(context, 'helper'),
          ),
          const SizedBox(width: 32),
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
