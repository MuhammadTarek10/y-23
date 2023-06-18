import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class QuizRepository {
  final RemoteQuizzer remoteQuizzer;
  const QuizRepository({required this.remoteQuizzer});

  //* Quizzes
  Future<List<Quiz>?> getAllQuizzes() async {
    return await remoteQuizzer.getAllQuizzes();
  }

  Future<Quiz?> getQuizById(String id) async {
    return await remoteQuizzer.getQuizById(id);
  }

  Future<bool?> addOrUpdateQuiz(Quiz quiz) async {
    return await remoteQuizzer.addOrUpdateQuiz(quiz);
  }

  Future<bool?> deleteQuiz(Quiz quiz) async {
    return await remoteQuizzer.deleteQuiz(quiz);
  }

  //* Quiz Results
  Future<List<QuizResult>?> getQuizResults(String userId) async {
    return await remoteQuizzer.getQuizResultsByUserId(userId);
  }

  Future<List<QuizResult>?> getAllQuizResults() async {
    return await remoteQuizzer.getAllQuizResults();
  }

  Future<bool?> saveQuizResult({
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    return await remoteQuizzer.saveQuizResult(
      userId: userId,
      quizId: quizId,
      selectedOptions: selectedOptions,
      score: score,
      totalQuestions: totalQuestions,
    );
  }

  Future<bool?> updateQuizResult({
    required String id,
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    return await remoteQuizzer.updateQuizResult(
      id: id,
      userId: userId,
      quizId: quizId,
      selectedOptions: selectedOptions,
      score: score,
      totalQuestions: totalQuestions,
    );
  }
}
