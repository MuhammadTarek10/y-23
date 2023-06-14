import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

class QuestionsStateNotifier extends StateNotifier<List<Question>?> {
  QuestionsStateNotifier() : super(null);

  void addQuestion(Question question) {
    state = [...state!, question];
  }

  void removeQuestion(Question question) {
    state = [...state!..remove(question)];
  }

  void updateQuestion(Question question) {
    state = [
      ...state!
        ..remove(question)
        ..add(question)
    ];
  }
}
