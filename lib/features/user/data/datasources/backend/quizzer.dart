import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/data/datasources/quiz_datasource.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';

class RemoteQuizzer extends QuizDataSource {
  //* Quizzes
  @override
  Future<List<Quiz>?> getAllQuizzes() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .get();

    return data.docs.map((e) => Quiz.fromJson(e.id, e.data())).toList();
  }

  @override
  Future<Quiz?> getQuizById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .doc(id)
        .get();

    return Quiz.fromJson(data.id, data.data()!);
  }

  @override
  Future<bool?> saveQuiz(Quiz quiz) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizzes)
          .add(quiz.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool?> updateQuiz(Quiz quiz) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizzes)
          .doc(quiz.id)
          .update(quiz.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool?> deleteQuiz(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizzes)
          .doc(id)
          .delete();
      return true;
    } catch (_) {
      return false;
    }
  }


  //* Quiz Results
  @override
  Future<bool?> saveQuizResult({
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    try {
      final quizResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizResults)
          .where(FirebaseFieldName.quizResultQuizId, isEqualTo: quizId)
          .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
          .limit(1)
          .get();

      if (quizResult.docs.isNotEmpty) {
        await quizResult.docs.first.reference.update({
          FirebaseFieldName.quizResultScore: score,
          FirebaseFieldName.quizResultIsTaken: true,
          FirebaseFieldName.quizResultSelectedOption: selectedOptions,
          FirebaseFieldName.quizResultIsPassed: score / totalQuestions >= 0.5,
        });
        return true;
      }

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizResults)
          .add({
        FirebaseFieldName.quizResultId: quizId,
        FirebaseFieldName.quizResultUserId: userId,
        FirebaseFieldName.quizResultQuizId: quizId,
        FirebaseFieldName.quizResultScore: score,
        FirebaseFieldName.quizResultSelectedOption: selectedOptions,
        FirebaseFieldName.quizResultIsTaken: true,
        FirebaseFieldName.quizResultIsPassed: score >= 3,
      });
      return true;
    } catch (_) {
      return null;
    }
  }

  Future<QuizResult?> getQuizResult(
    String userId,
    String quizId,
  ) async {
    final quizResult = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultQuizId, isEqualTo: quizId)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .limit(1)
        .get();

    if (quizResult.docs.isNotEmpty) {
      return QuizResult.fromJson(
          quizResult.docs.first.id, quizResult.docs.first.data());
    }

    return QuizResult(
      id: quizId,
      userId: userId,
      quizId: quizId,
      isTaken: false,
      selectedOptions: {},
      score: 0,
      isPassed: false,
    );
  }

  Future<QuizResult?> getQuizResultByQuizId(String quizId) async {
    final quizResult = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultQuizId, isEqualTo: quizId)
        .limit(1)
        .get();

    if (quizResult.docs.isNotEmpty) {
      return QuizResult.fromJson(
          quizResult.docs.first.id, quizResult.docs.first.data());
    }

    return null;
  }

  @override
  Future<List<QuizResult>?> getQuizResultsByUserId(String userId) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .get();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .get();

    if (quizResults.docs.length < quizzes.docs.length) {
      for (final quiz in quizzes.docs) {
        if (!quizResults.docs.any((element) =>
            element[FirebaseFieldName.quizResultQuizId] ==
            quiz[FirebaseFieldName.quizId])) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.quizResults)
              .add({
            FirebaseFieldName.quizResultUserId: userId,
            FirebaseFieldName.quizResultQuizId: quiz.id,
            FirebaseFieldName.quizResultScore: 0,
            FirebaseFieldName.quizResultSelectedOption: {},
            FirebaseFieldName.quizResultIsTaken: false,
            FirebaseFieldName.quizResultIsPassed: false,
          });
        }
      }

      return getQuizResultsByUserId(userId);
    }

    return quizResults.docs
        .map((e) => QuizResult.fromJson(e.id, e.data()))
        .toList();
  }

  Future<List<Quiz>?> getQuizzesByUserId(String userId) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .get();

    final quizIds = quizResults.docs
        .map((e) => e[FirebaseFieldName.quizResultQuizId] as String)
        .toList();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .where(FirebaseFieldName.quizId, whereIn: quizIds)
        .get();

    return quizzes.docs.map((e) => Quiz.fromJson(e.id, e.data())).toList();
  }

  Future<List<Quiz>?> getQuizzesByUserIdAndIsPassed(
      String userId, bool isPassed) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .where(FirebaseFieldName.quizResultIsPassed, isEqualTo: isPassed)
        .get();

    final quizIds = quizResults.docs
        .map((e) => e[FirebaseFieldName.quizResultQuizId] as String)
        .toList();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .where(FirebaseFieldName.quizId, whereIn: quizIds)
        .get();

    return quizzes.docs.map((e) => Quiz.fromJson(e.id, e.data())).toList();
  }

  Future<List<Quiz>> getQuizzesByUserIdAndIsTaken(
      String userId, bool isTaken) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .where(FirebaseFieldName.quizResultIsTaken, isEqualTo: isTaken)
        .get();

    final quizIds = quizResults.docs
        .map((e) => e[FirebaseFieldName.quizResultQuizId] as String)
        .toList();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .where(FirebaseFieldName.quizId, whereIn: quizIds)
        .get();

    return quizzes.docs.map((e) => Quiz.fromJson(e.id, e.data())).toList();
  }

  Future<List<Quiz>> getQuizzesByUserIdAndScore(
      String userId, int score) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .where(FirebaseFieldName.quizResultScore, isEqualTo: score)
        .get();

    final quizIds = quizResults.docs
        .map((e) => e[FirebaseFieldName.quizResultQuizId] as String)
        .toList();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .where(FirebaseFieldName.quizId, whereIn: quizIds)
        .get();

    return quizzes.docs.map((e) => Quiz.fromJson(e.id, e.data())).toList();
  }

  @override
  Future<List<QuizResult>?> getAllQuizResults() async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .get();

    return quizResults.docs
        .map((e) => QuizResult.fromJson(e.id, e.data()))
        .toList();
  }

  @override
  Future<bool?> updateQuizResult({
    required String id,
    required String userId,
    required String quizId,
    required Map<String, String> selectedOptions,
    required int score,
    required int totalQuestions,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizResults)
          .doc(id)
          .update({
        FirebaseFieldName.quizResultUserId: userId,
        FirebaseFieldName.quizResultQuizId: quizId,
        FirebaseFieldName.quizResultScore: score,
        FirebaseFieldName.quizResultSelectedOption: selectedOptions,
        FirebaseFieldName.quizResultIsTaken: true,
        FirebaseFieldName.quizResultIsPassed: score / totalQuestions >= 0.5,
      });
      return true;
    } catch (_) {
      return null;
    }
  }
}
