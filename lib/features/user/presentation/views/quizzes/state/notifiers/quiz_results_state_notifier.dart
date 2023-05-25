import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class QuizResultStateNotifier extends StateNotifier<List<QuizResult>?> {
  final quizzer = const Quizzer();
  final String userId;
  QuizResultStateNotifier({required this.userId}) : super(null) {
    getQuizResults(userId);
  }

  Future<void> getQuizResults(String userId) async {
    state = await quizzer.getQuizResultsByUserId(userId);
  }

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required int score,
    required int totalQuestions,
  }) async {
    await quizzer.saveQuizResult(
      userId: userId,
      quizId: quizId,
      score: score,
      totalQuestions: totalQuestions
    );
    await getQuizResults(userId);
  }
}
