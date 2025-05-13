import 'package:flutter/material.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/page_button.dart';
import 'package:go_router/go_router.dart';

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

  final List<String> relations = ['Son', 'Daughter', 'Grandson', 'Granddaughter', 'Enter Manually'];
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
              const Text('Enter Elder’s Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Please enter the elder’s personal information.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              _buildTextField(label: '성함	Full Name', hint: 'Please enter the full name.', controller: nameController),
              _buildTextField(label: 'Age', hint: 'Please enter the age.', controller: ageController),
              _buildDropdownField(),
              if (selectedRelation == 'Enter Manually')
                _buildTextField(label: 'Enter Relationship Manually', hint: 'e.x., neighbor, acquaintance', controller: customRelationController),
              _buildTextField(label: 'Phone Number', hint: 'Please enter your phone number.', controller: phoneController),

              const Spacer(),
              BottomNextBackNavigation(
                onBack: () => Navigator.pop(context),
                onNext: () => context.push('/signup/meal-alert'),
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
          const Text('Relationship to the Elder', style: TextStyle(fontWeight: FontWeight.bold)),
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
              hintText: 'Please select a relationship.',
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
