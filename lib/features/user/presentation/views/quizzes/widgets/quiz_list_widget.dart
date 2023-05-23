import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';
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
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(quiz.name),
          subtitle: Text(quiz.id),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
