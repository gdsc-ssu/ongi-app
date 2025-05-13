import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import 'package:ongi/state/account_type.dart';

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
                  onPressed: () {
                  hasCompletedSignUp = true; // ✅ 회원가입 완료 표시
                  context.go('/account-select'); // ✅ 계정 선택 화면으로 이동
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

