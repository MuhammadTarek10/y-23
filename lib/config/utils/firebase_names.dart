class FirebaseFieldName {
  //* Users
  static const String userId = "uid";
  static const String displayName = "displayName";
  static const String email = "email";
  static const String photoUrl = "photoUrl";
  static const String isAdmin = "isAdmin";
  static const String feedback = "feedback";

  //* Quizzes
  static const String quizId = "id";
  static const String quizTitle = "name";

  //* Questions
  static const String questionId = "id";
  static const String questionTitle = "title";
  static const String questionOptions = "options";
  static const String questionAnswer = "answer";
  static const String questionQuizId = "quizId";

  //* Quiz Results
  static const String quizResultId = "id";
  static const String quizResultUserId = "userId";
  static const String quizResultQuizId = "quizId";
  static const String quizResultIsTaken = "isTaken";
  static const String quizResultSelectedOption = "selectedOptions";
  static const String quizResultScore = "score";
  static const String quizResultIsPassed = "isPassed";

  //* Sessions
  static const String sessionsId = "id";
  static const String sessionsTitle = "title";
  static const String sessionsPoints = "points";
  static const String sessionsDocumentationLink = "documentationLink";
  static const String sessionsPhotoUrl = "photoUrl";
  static const String sessionsFeedback = "feedback";

  //* Tasks
  static const String tasksId = "id";
  static const String tasksTitle = "title";
  static const String tasksDescription = "description";
  static const String tasksDocumentationLink = "documentationLink";
  static const String tasksPoints = "points";
  static const String tasksFeedback = "feedback";

  //* Task Submissions
  static const String taskSubmissionsId = "id";
  static const String taskSubmissionsTaskId = "taskId";
  static const String taskSubmissionsUserId = "userId";
  static const String submission = "submission";
  static const String isTaskSubmitted = "isSubmitted";
  static const String taskSubmissionsIsCorrect = "isCorrect";
  static const String taskSubmissionsFeedback = "feedback";

  const FirebaseFieldName._();
}

class FirebaseCollectionName {
  static const String users = "users";
  static const String quizzes = "quizzes";
  static const String questions = "questions";
  static const String quizResults = "quizResults";
  static const String sessions = "sessions";
  static const String tasks = "tasks";
  static const String taskSubmissions = "taskSubmissions";

  const FirebaseCollectionName._();
}
