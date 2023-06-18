import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

@immutable
class Quiz {
  final String? id;
  final String title;
  final List<Question> questions;
  final String? photoUrl;

  const Quiz({
    required this.title,
    required this.questions,
    this.id,
    this.photoUrl,
  });

  Quiz copyWith({
    String? id,
    String? title,
    List<Question>? questions,
    String? photoUrl,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory Quiz.fromJson(String? id, Map<String, dynamic> json) {
    return Quiz(
      id: id as String,
      title: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'questions': questions.map((e) => e.toJson()).toList(),
      'photoUrl': photoUrl,
    };
  }
}
