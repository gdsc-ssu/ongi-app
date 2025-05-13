import 'package:flutter/material.dart';

class ElderShowVoiceScreen extends StatefulWidget {
  const ElderShowVoiceScreen({Key? key}) : super(key: key);

  @override
  State<ElderShowVoiceScreen> createState() => _ElderShowVoiceScreenState();
}

class _ElderShowVoiceScreenState extends State<ElderShowVoiceScreen> {
  int selected = 0; // 0: 아나운서, 1: 보호자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
                      SizedBox(width: 2),
                      Text('Back', style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: Text('Change Notification Voice', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selected = 0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: selected == 0 ? Colors.white : Color(0xFFFF8A4D),
                        border: Border.all(color: Color(0xFFFF8A4D), width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Announcer',
                          style: TextStyle(
                            color: selected == 0 ? Color(0xFFFF8A4D) : Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => setState(() => selected = 1),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: selected == 1 ? Color(0xFFFF8A4D) : Colors.white,
                        border: Border.all(color: Color(0xFFFF8A4D), width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Caregiver',
                          style: TextStyle(
                            color: selected == 1 ? Colors.white : Color(0xFFFF8A4D),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
