import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import '../../models/signup_form_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class SignupInputScreen extends StatelessWidget {
  const SignupInputScreen({super.key});

  final int currentStep = 2;
  final int totalSteps = 5;

  @override
  Widget build(BuildContext context) {
    final _idController = TextEditingController();
    final _pwController = TextEditingController();
    final _pwConfirmController = TextEditingController();
    final _phoneController = TextEditingController();
    final _verifyController = TextEditingController();
    final _nameController = TextEditingController();

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
              const Text(
                '회원가입',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('회원가입 정보를 입력해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              _InputField(label: '아이디', hint: '아이디를 입력해주세요.', controller: _idController, hasButton: true, buttonText: '중복확인'),
              _InputField(label: '비밀번호', hint: '비밀번호를 입력해주세요.', controller: _pwController, obscureText: true),
              _InputField(
                label: '비밀번호 확인',
                hint: '비밀번호를 다시 한 번 입력해주세요.',
                controller: _pwConfirmController,
                compareWithController: _pwController,
                obscureText: true,
              ),
              _InputField(label: '전화번호', hint: '전화번호를 입력해주세요.', controller: _phoneController, hasButton: true, buttonText: '인증번호 받기'),
              _InputField(
                label: '인증번호',
                hint: '인증번호를 입력해주세요.',
                controller: _verifyController,
                compareWithController: _phoneController, 
                hasButton: true,
                buttonText: '확인',
              ),

              _InputField(label: '성함', hint: '성함을 입력해주세요.', controller: _nameController),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () {
                  if (_idController.text.trim().isEmpty ||
                      _pwController.text.trim().isEmpty ||
                      _pwConfirmController.text.trim().isEmpty ||
                      _phoneController.text.trim().isEmpty ||
                      _verifyController.text.trim().isEmpty ||
                      _nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 항목을 입력해주세요.')),
                    );
                    return;
                  }

                  final form = context.read<SignUpFormModel>();
                  form.loginId = _idController.text.trim();
                  form.password = _pwController.text.trim();
                  form.guardianPhone = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
                  form.guardianName = _nameController.text.trim();

                  context.push('/signup/senior-info');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatefulWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final bool hasButton;
  final String? buttonText;
  final TextEditingController? controller;
  final TextEditingController? compareWithController; 

  const _InputField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.hasButton = false,
    this.buttonText,
    this.controller,
    this.compareWithController,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  String? _feedbackMessage;
  Color _feedbackColor = Colors.transparent;
  Color _borderColor = Colors.grey.shade300;

  Future<void> _checkDuplicateId() async {
    final id = widget.controller?.text.trim();
    if (id == null || id.isEmpty) return;

    try {
      final uri = Uri.parse('http://13.124.122.198:8080/user/check-id?id=$id');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final json = jsonDecode(decoded);

        final success = json['success'];
        final resultMessage = json['message'];

        setState(() {
          _feedbackMessage = success ? "":"중복된 아이디가 존재합니다.";
          _feedbackColor = success ? Colors.blue : Colors.red;
          _borderColor = success ? Colors.blue : Colors.red;
        });
      } else {
        setState(() {
          _feedbackMessage = '서버 오류: ${response.statusCode}';
          _feedbackColor = Colors.red;
          _borderColor = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _feedbackMessage = '에러 발생: $e';
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      });
    }
  }

  Future<void> _sendVerificationCode() async {
    final phone = widget.controller?.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone == null || phone.length != 11) {
      setState(() {
        _feedbackMessage = '올바른 전화번호를 입력해주세요.';
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      });
      return;
    }

    try {
      final uri = Uri.parse('http://13.124.122.198:8080/sms/send-sms?phoneNumber=$phone');
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final json = jsonDecode(decoded);

        final success = json['success'];
        final message = json['message'];

        setState(() {
          _feedbackMessage = success ? "인증번호가 발송되었습니다.":"";
          _feedbackColor = success ? Colors.blue : Colors.red;
          _borderColor = success ? Colors.blue : Colors.red;
        });
      } else {
        setState(() {
          _feedbackMessage = '서버 오류: ${response.statusCode}';
          _feedbackColor = Colors.red;
          _borderColor = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _feedbackMessage = '에러 발생: $e';
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      });
    }
  }

  Future<void> _verifySmsCode() async {
    final phone = widget.compareWithController?.text.replaceAll(RegExp(r'[^0-9]'), '');
    final code = widget.controller?.text.trim();

    if (phone == null || phone.length != 11 || code == null || code.isEmpty) {
      setState(() {
        _feedbackMessage = '인증번호를 입력해주세요.';
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      });
      return;
    }

    try {
      final uri = Uri.parse('http://13.124.122.198:8080/sms/verify-sms');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phone,
          'code': code,
        }),
      );

      final decoded = utf8.decode(response.bodyBytes);
      print('📨 인증 응답 원문: $decoded'); // ✅ 여기 추가

      if (response.statusCode == 200) {
        final json = jsonDecode(decoded);

        final success = json['success'];
        final message = json['message'];
        final data = json['data'];

        print('✅ success: $success, data: $data, message: $message'); 

        setState(() {
          _feedbackMessage = data == true ? "인증에 성공했습니다." : "인증번호가 틀렸습니다.";
          _feedbackColor = data == true ? Colors.blue : Colors.red;
          _borderColor = data == true ? Colors.blue : Colors.red;
        });
      } else {
        print('❌ 서버 오류 ${response.statusCode}');
        setState(() {
          _feedbackMessage = '서버 오류: ${response.statusCode}';
          _feedbackColor = Colors.red;
          _borderColor = Colors.red;
        });
      }
    } catch (e) {
      print('❌ 예외 발생: $e');
      setState(() {
        _feedbackMessage = '에러 발생: $e';
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      });
    }
  }

  void _validatePasswordConfirmation(String input) {
    final origin = widget.compareWithController?.text ?? "";
    setState(() {
      if (input == origin) {
        _feedbackMessage = "비밀번호가 일치합니다.";
        _feedbackColor = Colors.blue;
        _borderColor = Colors.blue;
      } else {
        _feedbackMessage = "비밀번호가 일치하지 않습니다.";
        _feedbackColor = Colors.red;
        _borderColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                obscureText: widget.obscureText,
                onChanged: (text) {
                  if (widget.label == '비밀번호 확인') {
                    _validatePasswordConfirmation(text);
                  }
                },
                inputFormatters: widget.label == '전화번호'
                  ? [PhoneNumberFormatter()]
                  : [],
                decoration: InputDecoration(
                  hintText: widget.hint,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: _borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: _borderColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
            if (widget.hasButton && widget.buttonText != null) ...[
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (widget.label == '아이디') {
                    _checkDuplicateId();
                  } else if (widget.label == '전화번호') {
                    _sendVerificationCode();
                  } else if (widget.label == '인증번호') {
                    _verifySmsCode();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  minimumSize: const Size(0, 48),
                ),
                child: Text(widget.buttonText!),
              ),
            ]
          ],
        ),
        if (_feedbackMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              _feedbackMessage!,
              style: TextStyle(color: _feedbackColor, fontSize: 13),
            ),
          )
      ],
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == 2 || i == 6) {
        if (i != digits.length - 1) buffer.write('-');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
