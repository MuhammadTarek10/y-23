class QuizResult {
  final String? id;
  final String userId;
  final String quizId;
  final bool isTaken;
  final Map<String, String> selectedOptions;
  final int score;
  final bool isPassed;

  QuizResult({
    this.id,
    required this.userId,
    required this.quizId,
    required this.isTaken,
    required this.selectedOptions,
    required this.score,
    required this.isPassed,
  });

  QuizResult copyWith({
    String? id,
    String? userId,
    String? quizId,
    bool? isTaken,
    Map<String, String>? selectedOptions,
    int? score,
    bool? isPassed,
  }) {
    return QuizResult(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      quizId: quizId ?? this.quizId,
      isTaken: isTaken ?? this.isTaken,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      score: score ?? this.score,
      isPassed: isPassed ?? this.isPassed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'quizId': quizId,
      'isTaken': isTaken,
      'selectedOptions': selectedOptions,
      'score': score,
      'isPassed': isPassed,
    };
  }

  factory QuizResult.fromJson(String? id, Map<String, dynamic> json) {
    return QuizResult(
      id: id,
      userId: json['userId'] as String,
      quizId: json['quizId'] as String,
      isTaken: json['isTaken'] as bool,
      selectedOptions: (json['selectedOptions'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      score: json['score'] as int,
      isPassed: json['isPassed'] as bool,
    );
  }

  firstWhere(bool Function(dynamic element) param0) {}
}
