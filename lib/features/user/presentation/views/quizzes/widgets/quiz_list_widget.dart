import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';

class QuizListWidget extends StatelessWidget {
  const QuizListWidget({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, Routes.quizzesRoute, arguments: quiz),
      child: Container(
        height: AppSizes.s100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(AppSizes.s10),
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
                  quiz.questions.length.toString(),
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
