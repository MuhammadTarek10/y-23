import 'package:y23/features/auth/domain/entities/user.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class LeaderboardData {
  Iterable<User> users;
  Iterable<Quiz> quizzes;
  Iterable<QuizResult> quizResults;
  Iterable<TaskSubmission> submissions;

  LeaderboardData(
    this.users,
    this.quizzes,
    this.quizResults,
    this.submissions,
  );

  Map<User, int> calculateScores() {
    Map<String, int> idWithScore = {};
    Map<User, int> usersScore = {};
    quizResults.map(
      (e) {
        if (idWithScore.containsKey(e.userId)) {
          idWithScore[e.userId] = idWithScore[e.userId]! + e.score;
        } else {
          idWithScore[e.userId] = e.score;
        }
      },
    ).toList();

    submissions.map(
      (e) {
        if (idWithScore.containsKey(e.userId)) {
          idWithScore[e.userId] = idWithScore[e.userId]! + (e.points ?? 0);
        } else {
          idWithScore[e.userId] = (e.points ?? 0);
        }
      },
    ).toList();

    users.map(
      (e) {
        if (idWithScore.containsKey(e.id)) {
          usersScore[e] = idWithScore[e.id]!;
        }
      },
    ).toList();

    usersScore = Map.fromEntries(
      usersScore.entries.toList()
        ..sort(
          (a, b) => b.value.compareTo(a.value),
        ),
    );

    return usersScore;
  }
}
