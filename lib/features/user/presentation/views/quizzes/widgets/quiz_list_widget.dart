import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view_params.dart';

class QuizListWidget extends StatelessWidget {
  const QuizListWidget({
    super.key,
    required this.quiz,
    required this.result,
  });

  final Quiz quiz;
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.quizzesRoute,
          arguments: QuizViewParams(
            quiz: quiz,
            result: result,
          )),
      child: Container(
        height: AppSizes.s100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(AppSizes.s10),
          color: result.isTaken
              ? result.isPassed
                  ? Colors.green.withOpacity(0.4)
                  : Colors.red.withOpacity(0.4)
              : Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      quiz.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      quiz.id,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "${result.score}/${quiz.questions.length}",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
