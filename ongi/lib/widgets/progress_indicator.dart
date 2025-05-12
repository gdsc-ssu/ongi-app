import 'package:flutter/material.dart';

class ProgressStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isCurrent = index + 1 == currentStep;
        final isCompleted = index + 1 <= currentStep;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: isCurrent ? 4 : 0),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.deepOrange : Colors.grey.shade300,
                ),
              ),
              if (isCurrent)
                const SizedBox(height: 4),
            ],
          ),
        );
      }),
    );
  }
}
