import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskSubmission {
  final String id;
  final String taskId;
  final String userId;
  final dynamic submission;
  final bool? isCorrect;
  final List<dynamic>? feedback;

  const TaskSubmission({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.submission,
    this.isCorrect,
    this.feedback,
  });

  TaskSubmission copyWith({
    String? id,
    String? taskId,
    String? userId,
    dynamic submission,
    bool? isCorrect,
    List<dynamic>? feedback,
  }) {
    return TaskSubmission(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      submission: submission,
      isCorrect: isCorrect,
      feedback: feedback,
    );
  }

  factory TaskSubmission.fromJson(String id, Map<String, dynamic> json) {
    return TaskSubmission(
      id: id,
      taskId: json['taskId'] as String,
      userId: json['userId'] as String,
      submission: json['submission'],
      isCorrect: json['isCorrect'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'userId': userId,
      'submission': submission,
      'isCorrect': isCorrect,
      'feedback': feedback,
    };
  }
}