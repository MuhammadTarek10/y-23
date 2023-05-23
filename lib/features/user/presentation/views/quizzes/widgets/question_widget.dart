import 'package:flutter/material.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/option_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(AppSizes.s10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.s10),
          const Divider(color: Colors.white),
          StatefulBuilder(
            builder: (context, setState) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final option = question.options[index];
                  return OptionWidget(
                    onPressed: () => setState(() {
                      question.selectedOption = option;
                    }),
                    isSelected: question.selectedOption == option,
                    option: option,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: question.options.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
