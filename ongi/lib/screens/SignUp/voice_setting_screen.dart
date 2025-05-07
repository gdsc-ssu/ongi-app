
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import 'package:flutter/services.dart';

class VoiceSettingScreen extends StatefulWidget {
  const VoiceSettingScreen({super.key});

  @override
  State<VoiceSettingScreen> createState() => _VoiceSettingScreenState();
}

class _VoiceSettingScreenState extends State<VoiceSettingScreen> {
  final int currentStep = 5;
  final int totalSteps = 5;
  bool isRecording = false;
  Duration recordedDuration = Duration.zero;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((Duration elapsed) {
      if (isRecording) {
        setState(() {
          recordedDuration = elapsed;
        });
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
      recordedDuration = Duration.zero;
    });
    _ticker.start();
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
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
              if (isRecording) ...[
                LinearProgressIndicator(
                  value: recordedDuration.inSeconds / 60,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDuration(recordedDuration),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (isRecording) {
                    _stopRecording();
                  } else {
                    _startRecording();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  isRecording ? '설정 완료' : '녹음 시작',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Ticker {
  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _running = false;
  late final Stopwatch _stopwatch;
  late final TickerFuture _tickerFuture;

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

class TickerFuture {}
