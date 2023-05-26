class Question {
  final String id;
  final String title;
  final List<String> options;
  final String answer;

  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.answer,
  });

  Question copyWith({
    String? id,
    String? title,
    List<String>? options,
    String? selectedOption,
    String? answer,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'options': options,
      'answer': answer,
    };
  }
}
