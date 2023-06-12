import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/domain/entities/user.dart';
import 'package:y23/features/user/data/models/leaderboard_data.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class LeaderboardNotifier extends StateNotifier<Map<User, int>?> {
  LeaderboardNotifier() : super(null) {
    getData();
  }

  Future<void> getData() async {
    final usersJson = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.isAdmin, isEqualTo: false)
        .get();

    final users = usersJson.docs.map((e) => User.fromJson(e.data()));

    final quizzesJson = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .get();

    final quizzes = quizzesJson.docs.map((e) => Quiz.fromJson(e.id, e.data()));

    final quizResultsJson = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizResults)
        .get();

    final quizResults =
        quizResultsJson.docs.map((e) => QuizResult.fromJson(e.id, e.data()));

    final submissionsJson = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .get();

    final submissions = submissionsJson.docs
        .map((e) => TaskSubmission.fromJson(e.id, e.data()));

    final data = LeaderboardData(
      users,
      quizzes,
      quizResults,
      submissions,
    );

    state = data.calculateScores();
  }
}
