import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/option_widget.dart';

typedef OptionCallback = void Function(String option);

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.isTaken,
    required this.question,
    required this.selectedOption,
    required this.onPressed,
  });

  final bool isTaken;
  final Question question;
  final String selectedOption;
  final OptionCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(AppSizes.s10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.fakeWhite),
          ),
          const SizedBox(height: AppSizes.s10),
          const Divider(thickness: AppSizes.s4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final option = question.options[index];
              return OptionWidget(
                onPressed: () => isTaken ? null : onPressed(option),
                isSelected: selectedOption == option,
                isRight: isTaken ? question.answer == option : false,
                option: option,
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: question.options.length,
          ),
        ],
      ),
    );
  }
}
