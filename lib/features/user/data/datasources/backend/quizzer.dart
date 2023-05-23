import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';

class Quizzer {
  const Quizzer();

  Future<List<Quiz>> getQuizzes() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .get();

    return data.docs.map((e) => Quiz.fromJson(e.data())).toList();
  }

  Future<Quiz> getQuizById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .doc(id)
        .get();

    return Quiz.fromJson(data.data()!);
  }

  Future<bool> saveQuiz(Quiz quiz) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizzes)
          .add(quiz.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateQuiz(Quiz quiz) async {
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

  Future<bool> deleteQuiz(String id) async {
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

  Future<bool> saveQuizResult({
    required String userId,
    required String quizId,
    required int score,
  }) async {
    try {
      final quizResult = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizResults)
          .where(FirebaseFieldName.quizResultId, isEqualTo: quizId)
          .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
          .limit(1)
          .get();

      if (quizResult.docs.isNotEmpty) {
        await quizResult.docs.first.reference.update({
          FirebaseFieldName.quizResultScore: score,
        });
        return true;
      }

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.quizResults)
          .add({
        FirebaseFieldName.quizResultUserId: userId,
        FirebaseFieldName.quizResultId: quizId,
        FirebaseFieldName.quizResultScore: score,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<int> getQuizResult({
    required String userId,
    required String quizId,
  }) async {
    final quizResult = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultId, isEqualTo: quizId)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .limit(1)
        .get();

    if (quizResult.docs.isNotEmpty) {
      return quizResult.docs.first[FirebaseFieldName.quizResultScore] as int;
    }

    return 0;
  }

  Future<List<Quiz>> getQuizzesByUserId(String userId) async {
    final quizResults = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .where(FirebaseFieldName.quizResultUserId, isEqualTo: userId)
        .get();

    final quizIds = quizResults.docs
        .map((e) => e[FirebaseFieldName.quizResultId] as String)
        .toList();

    final quizzes = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .where(FirebaseFieldName.quizId, whereIn: quizIds)
        .get();

    return quizzes.docs.map((e) => Quiz.fromJson(e.data())).toList();
  }
}
