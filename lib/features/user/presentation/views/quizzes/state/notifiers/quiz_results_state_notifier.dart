import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class QuizResultStateNotifier extends StateNotifier<List<QuizResult>?> {
  final quizzer = const Quizzer();
  final String userId;
  QuizResultStateNotifier({required this.userId}) : super(null) {
    getQuizResults();
  }

  Future<void> getQuizResults() async {
    state = await quizzer.getQuizResultsByUserId(userId);
  }

  Future<void> getAllQuizResults() async {
    state = await quizzer.getAllQuizResults();
  }

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    await quizzer.saveQuizResult(
        userId: userId,
        quizId: quizId,
        selectedOptions: selectedOptions,
        score: score,
        totalQuestions: totalQuestions);
    await getQuizResults();
  }
}
