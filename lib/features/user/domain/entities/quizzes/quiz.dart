import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

@immutable
class Quiz {
  final String id;
  final String name;
  final List<Question> questions;

  const Quiz({
    required this.id,
    required this.name,
    required this.questions,
  });

  Quiz copyWith({
    String? id,
    String? name,
    List<Question>? questions,
  }) {
    return Quiz(
      id: id ?? this.id,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  factory Quiz.fromJson(String? id, Map<String, dynamic> json) {
    return Quiz(
      id: id as String,
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'questions':
          questions.map((e) => e.toJson()).toList(),
    };
  }
}
