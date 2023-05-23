class FirebaseFieldName {
  //* Users
  static const String userId = "uid";
  static const String displayName = "displayName";
  static const String email = "email";

  //* Quizzes
  static const String quizId = "id";
  static const String quizName = "name";

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
  static const String quizResultScore = "score";

  const FirebaseFieldName._();
}

class FirebaseCollectionName {
  static const String users = "users";
  static const String quizzes = "quizzes";
  static const String questions = "questions";
  static const String quizResults = "quizResults";

  const FirebaseCollectionName._();
}
