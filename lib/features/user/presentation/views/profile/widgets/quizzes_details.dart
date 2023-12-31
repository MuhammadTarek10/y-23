import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class QuizzesDetails extends StatelessWidget {
  const QuizzesDetails({
    super.key,
    required this.quizzes,
    required this.quizResults,
    required this.onPressed,
  });

  final List<Quiz> quizzes;
  final List<QuizResult> quizResults;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final score = quizResults
        .map((result) => (result.score))
        .reduce((value, element) => value + element);
    final questions = quizzes
        .map((quiz) => (quiz.questions.length))
        .reduce((value, element) => value + element);
    final good = score / questions > 0.5;
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                AppStrings.quizzesTaken.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                quizResults
                    .map((result) => (result.isTaken ? 1 : 0))
                    .reduce((value, element) => value + element)
                    .toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                AppStrings.quizzesPassed.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                quizResults
                    .map((result) => (result.isPassed ? 1 : 0))
                    .reduce((value, element) => value + element)
                    .toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                AppStrings.score.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                "$score/$questions",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: good
                          ? const Color.fromARGB(255, 45, 194, 50)
                          : const Color.fromARGB(255, 181, 63, 54),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
