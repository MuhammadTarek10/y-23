import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';

class QuizzesStateNotifier extends StateNotifier<List<Quiz>> {
  final quizzer = const Quizzer();
  QuizzesStateNotifier() : super([]) {
    getQuizzes();
  }

  Future<void> getQuizzes() async {
    state = await quizzer.getQuizzes();
  }

  Future<void> getQuizById(String id) async {
    state = [await quizzer.getQuizById(id)];
  }

  Future<void> saveQuiz(Quiz quiz) async {
    await quizzer.saveQuiz(quiz);
    state = await quizzer.getQuizzes();
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await quizzer.updateQuiz(quiz);
    state = await quizzer.getQuizzes();
  }

  Future<void> deleteQuiz(String id) async {
    await quizzer.deleteQuiz(id);
    state = await quizzer.getQuizzes();
  }

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required int score,
  }) async {
    await quizzer.saveQuizResult(
      userId: userId,
      quizId: quizId,
      score: score,
    );
  }
}
