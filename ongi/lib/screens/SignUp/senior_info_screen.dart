import 'package:flutter/material.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../../models/signup_form_model.dart';
import 'package:provider/provider.dart';


class SeniorInfoScreen extends StatefulWidget {
  const SeniorInfoScreen({super.key});

  @override
  State<SeniorInfoScreen> createState() => _SeniorInfoScreenState();
}

class _SeniorInfoScreenState extends State<SeniorInfoScreen> {
  final int currentStep = 3;
  final int totalSteps = 5;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController customRelationController = TextEditingController();

  final List<String> relations = ['아들', '딸', '손자', '손녀', '직접입력'];
  String? selectedRelation;

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
              const Text('어르신 개인 정보 입력', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('어르신의 개인정보를 입력해주세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              _buildTextField(label: '성함', hint: '성함을 입력해주세요.', controller: nameController),
              _buildTextField(label: '연령', hint: '연령을 입력해주세요.', controller: ageController),
              _buildDropdownField(),
              if (selectedRelation == '직접입력')
                _buildTextField(label: '관계 직접 입력', hint: '예: 이웃, 지인 등', controller: customRelationController),
              _buildTextField(label: '전화번호', hint: '전화번호를 입력해주세요.', controller: phoneController),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () {
                  final name = nameController.text.trim();
                  final age = ageController.text.trim();
                  final phone = phoneController.text.trim();
                  final relation = selectedRelation;
                  final customRelation = customRelationController.text.trim();

                  final isPhoneValid = RegExp(r'^010-\d{4}-\d{4}$').hasMatch(phone);
                  final isAgeValid = RegExp(r'^\d+$').hasMatch(age);

                  if (name.isEmpty ||
                      age.isEmpty ||
                      phone.isEmpty ||
                      relation == null ||
                      (relation == '직접입력' && customRelation.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 항목을 입력해주세요.')),
                    );
                    return;
                  }

                  if (!isAgeValid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('연령은 숫자만 입력해주세요.')),
                    );
                    return;
                  }

                  if (!isPhoneValid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('전화번호 형식이 올바르지 않습니다.')),
                    );
                    return;
                  }

                  final form = context.read<SignUpFormModel>();

                  const relationMap = {
                    '아들': 'SON',
                    '딸': 'DAUGHTER',
                    '손자': 'GRANDSON',
                    '손녀': 'GRANDDAUGHTER',
                  };

                  form.seniorName = name;
                  form.seniorAge = int.parse(age);
                  form.seniorPhone = phone;
                  form.relation = selectedRelation == '직접입력'
    ? customRelation
    : relationMap[selectedRelation] ?? selectedRelation;
                  context.push('/signup/meal-alert');
                },

              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            inputFormatters: label == '연령'
              ? [FilteringTextInputFormatter.digitsOnly]
              : label == '전화번호'
                  ? [PhoneNumberFormatter()]
                  : [],
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('보호자와 어르신의 관계', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedRelation,
            items: relations
                .map((relation) => DropdownMenuItem<String>(
                      value: relation,
                      child: Text(relation),
                    ))
                .toList(),
            onChanged: (value) => setState(() => selectedRelation = value),
            decoration: InputDecoration(
              hintText: '관계를 선택해주세요.',
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
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