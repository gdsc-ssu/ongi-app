import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
// import 'package:ongi/state/account_type.dart';
import 'package:provider/provider.dart';
import 'package:ongi/models/signup_form_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class VoiceSettingScreen extends StatefulWidget {
  const VoiceSettingScreen({super.key});

  @override
  State<VoiceSettingScreen> createState() => _VoiceSettingScreenState();
}

class _VoiceSettingScreenState extends State<VoiceSettingScreen> {
  final int currentStep = 5;
  final int totalSteps = 5;

  bool isRecording = false;
  bool isRecorded = false;
  Duration recordedDuration = Duration.zero;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      if (isRecording) {
        setState(() => recordedDuration = elapsed);
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      isRecording = true;
      isRecorded = false;
      recordedDuration = Duration.zero;
    });
    _ticker.start();
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
      isRecorded = true;
    });
    _ticker.stop();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProgressStepIndicator(currentStep: currentStep, totalSteps: totalSteps),
              const SizedBox(height: 24),
              const Text('알림 방식 설정', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                '보호자의 목소리로 노약자분들에게\n다정한 알림을 전송해주세요.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                '목소리 녹음 시작하기',
                style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '녹음 버튼을 누르고 다음 문장을 읽어주세요\n녹음이 끝나면 녹음 중지를 눌러주세요',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  '엄마 아빠 약 먹었어?\n할머니 할아버지 약 드셨어요?\n약 먹는거 깜빡하셨죠?\n약 드셨어요? 좋은 하루 보내세요',
                  style: TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(height: 24),

              // 녹음 중일 때만 보이는 진행 표시 + 시간
              if (isRecording) ...[
                const LinearProgressIndicator(color: Colors.deepOrange),
                const SizedBox(height: 8),
                Text(_formatDuration(recordedDuration), textAlign: TextAlign.right),
              ],

              const Spacer(),

              // 버튼 영역
              if (isRecording) ...[
                ElevatedButton(
                  onPressed: _stopRecording,
                  style: _buttonStyle(),
                  child: const Text('녹음 중지'),
                ),
              ] else if (isRecorded) ...[
                Text('총 녹음 시간: ${_formatDuration(recordedDuration)}',
                    textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {}, // 재생 기능 추가 해야함.
                  style: _buttonStyle(),
                  child: const Text('다시 듣기'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                  await _submitSignupWithMeds(context);
                  context.go('/account-select');      
                },
  style: _buttonStyle(),
  child: const Text('설정 완료'),
),
              ] else ...[
                ElevatedButton(
                  onPressed: _startRecording,
                  style: _buttonStyle(),
                  child: const Text('녹음 시작'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.deepOrange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14),
      textStyle: const TextStyle(fontSize: 16),
    );
  }
}

class Ticker {
  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _running = false;
  late final Stopwatch _stopwatch;

  Ticker(this.onTick) {
    _stopwatch = Stopwatch();
  }

  void start() {
    if (_running) return;
    _running = true;
    _stopwatch.start();
    _tick();
  }

  void stop() {
    _running = false;
    _stopwatch.stop();
  }

  void _tick() async {
    while (_running) {
      await Future.delayed(const Duration(seconds: 1));
      onTick(_stopwatch.elapsed);
    }
  }

  void dispose() {
    _running = false;
    _stopwatch.stop();
  }
}

Future<void> _submitSignupWithMeds(BuildContext context) async {
  // 회원가입 요청
  final base = 'http://13.124.122.198:8080';
  final form = context.read<SignUpFormModel>();

  print('회원가입 요청 Body: ${jsonEncode(form.toJson())}');

  // 1. 회원가입
  final response = await http.post(
    Uri.parse('$base/user/signup'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(form.toJson()),
  );

  if (response.statusCode == 200) {
    print('회원가입 성공: ${response.body}');
  } else {
    print('회원가입 실패: ${response.statusCode}, ${response.body}');
  }

  // 2. 보호자 약관 동의
  final response2 = await http.post(Uri.parse('$base/user/guardian-agreement'));
  if (response.statusCode == 200) {
  print('회원가입 성공: ${response2.body}');
} else {
  print('회원가입 실패: ${response2.statusCode}, ${response2.body}');
}

  // 식사 등록
  for (final meal in form.meals) {
    await http.post(
      Uri.parse('http://13.124.122.198:8080/meals/new-meal'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(meal),
    );
  }

  // 3. 약 등록
  for (final med in form.medications) {
    http.Response? response3;
    if (med['type'] == 'timed') {
      response3 = await http.post(
        Uri.parse('$base/medications/fixed-time'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': med['name'],
          'timeList': med['times']
              .map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}')
              .toList(),
        }),
      );
    } else if (med['type'] == 'prepost') {
      response3 = await http.post(
        Uri.parse('$base/medications/meal-based'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': med['name'],
          'intakeTiming': med['intakeTiming'],
          'mealTypes': med['mealTypes'],
          'remindAfterMinutes': med['remindAfterMinutes'],
        }),
      );
    }

    if (response3 != null) {
      print('약 등록 응답 (${med['name']}): ${response3.statusCode}, ${response3.body}');
    } else {
      print('⚠️ ${med['name']} 은(는) 처리되지 않은 타입입니다: ${med['type']}');
    }
  }
  
}