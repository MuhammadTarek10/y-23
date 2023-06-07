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
}
