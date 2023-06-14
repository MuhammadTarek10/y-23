import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/domain/repositories/quiz_repository.dart';

class QuizResultStateNotifier extends StateNotifier<List<QuizResult>?> {
  final quizRepo = instance<QuizRepository>();
  final String userId;
  QuizResultStateNotifier({required this.userId}) : super(null) {
    getQuizResults();
  }

  Future<void> getQuizResults() async {
    state = await quizRepo.getQuizResults(userId);
  }

  Future<void> getAllQuizResults() async {
    state = await quizRepo.getAllQuizResults();
  }

  Future<void> addOrUpdateQuiz(Quiz quiz) async {
    await quizRepo.addOrUpdateQuiz(quiz);
    await getQuizResults();
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    await quizRepo.deleteQuiz(quiz.id!);
    await getQuizResults();
  }

  Future<void> saveQuizResult({
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    await quizRepo.saveQuizResult(
        userId: userId,
        quizId: quizId,
        selectedOptions: selectedOptions,
        score: score,
        totalQuestions: totalQuestions);
    await getQuizResults();
  }
}
