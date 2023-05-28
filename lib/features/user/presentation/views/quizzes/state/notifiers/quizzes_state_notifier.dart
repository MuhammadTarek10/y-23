import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';

class QuizzesStateNotifier extends StateNotifier<List<Quiz>?> {
  final quizzer = const Quizzer();
  QuizzesStateNotifier() : super(null) {
    getQuizzes();
  }

  Future<void> getQuizzes() async {
    final quizzes = await quizzer.getQuizzes();
    if (quizzes != null) quizzes.sort((a, b) => a.id.compareTo(b.id));
    state = quizzes;
  }

  Future<void> getQuizById(String id) async {
    final quiz = await quizzer.getQuizById(id);
    state = [quiz!];
  }

  Future<void> saveQuiz(Quiz quiz) async {
    await quizzer.saveQuiz(quiz);
    state = await quizzer.getQuizzes();
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await quizzer.updateQuiz(quiz);
    state = await quizzer.getQuizzes();
  }

  Future<void> deleteQuiz(String quizId) async {
    await quizzer.deleteQuiz(quizId);
    state = await quizzer.getQuizzes();
  }

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required int score,
    required Map<String, String> selectedOptions,
    required int totalQuestions,
  }) async {
    await quizzer.saveQuizResult(
      userId: userId,
      quizId: quizId,
      score: score,
      selectedOptions: selectedOptions,
      totalQuestions: totalQuestions,
    );
  }
}
