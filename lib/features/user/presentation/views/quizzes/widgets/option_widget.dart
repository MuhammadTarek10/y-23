import 'package:flutter/material.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.question,
    required this.option,
  });

  final Question question;
  final String option;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => question.selectedOption = option,
      child: ListTile(
        title: Text(option),
        leading: Radio<String>(
          value: option,
          groupValue: question.selectedOption,
          onChanged: (value) => question.selectedOption = value!,
        ),
      ),
    );
  }
}
