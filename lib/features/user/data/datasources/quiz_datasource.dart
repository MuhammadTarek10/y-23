import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

abstract class QuizDataSource {
  //* Quizzes
  Future<List<Quiz>?> getAllQuizzes();
  Future<Quiz?> getQuizById(String id);
  Future<bool?> saveQuiz(Quiz quiz);
  Future<bool?> updateQuiz(Quiz quiz);
  Future<bool?> deleteQuiz(String id);

  //* Quiz Results
  Future<List<QuizResult>?> getQuizResultsByUserId(String userId);
  Future<List<QuizResult>?> getAllQuizResults();
  Future<bool?> saveQuizResult({
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  });
  Future<bool?> updateQuizResult({
    required String id,
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  });
}
