import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/repositories/quiz_repository.dart';

class QuizzesStateNotifier extends StateNotifier<List<Quiz>?> {
  final quizzer = instance<QuizRepository>();
  QuizzesStateNotifier() : super(null) {
    getQuizzes();
  }

  Future<void> getQuizzes() async {
    final quizzes = await quizzer.getAllQuizzes();
    if (quizzes != null) quizzes.sort((a, b) => a.id!.compareTo(b.id!));
    state = quizzes;
  }

  Future<void> getQuizById(String id) async {
    final quiz = await quizzer.getQuizById(id);
    state = [quiz!];
  }

  Future<void> saveQuiz(Quiz quiz) async {
    await quizzer.addOrUpdateQuiz(quiz);
    state = await quizzer.getAllQuizzes();
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    await quizzer.deleteQuiz(quiz);
    state = await quizzer.getAllQuizzes();
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
