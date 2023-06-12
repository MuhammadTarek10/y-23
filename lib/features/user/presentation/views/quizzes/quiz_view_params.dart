import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

@immutable
class QuizViewParams {
  const QuizViewParams({
    required this.quiz,
    required this.result,
  });

  final Quiz quiz;
  final QuizResult? result;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizViewParams &&
          runtimeType == other.runtimeType &&
          quiz == other.quiz &&
          result == other.result;

  @override
  int get hashCode => quiz.hashCode ^ result.hashCode;

  @override
  String toString() => 'QuizViewParams{quiz: $quiz, result: $result}';
}
