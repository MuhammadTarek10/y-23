import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class QuizzesDetails extends StatelessWidget {
  const QuizzesDetails({
    super.key,
    required this.quizResults,
  });

  final List<QuizResult> quizResults;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              quizResults
                  .map((result) => (result.score))
                  .reduce((value, element) => value + element)
                  .toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
