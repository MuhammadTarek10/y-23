import 'package:flutter/foundation.dart' show immutable;

@immutable
class Question {
  final String title;
  final List<String> options;
  final String answer;

  const Question({
    required this.title,
    required this.options,
    required this.answer,
  });

  Question copyWith({
    String? title,
    List<String>? options,
    String? selectedOption,
    String? answer,
  }) {
    return Question(
      title: title ?? this.title,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answer: json['answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'options': options,
      'answer': answer,
    };
  }
}
