import 'package:flutter/foundation.dart' show immutable;

@immutable
class TaskSubmission {
  final String id;
  final String taskId;
  final String userId;
  final String? submissionUrl;
  final bool? isSubmitted;
  final bool? isCorrect;
  final int? points;
  final List<Map<String, dynamic>>? feedback;

  const TaskSubmission({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.submissionUrl,
    this.isSubmitted,
    this.isCorrect,
    this.points,
    this.feedback,
  });

  TaskSubmission copyWith({
    String? id,
    String? taskId,
    String? userId,
    dynamic submission,
    bool? isSubmitted,
    bool? isCorrect,
    int? points,
    List<Map<String, dynamic>>? feedback,
  }) {
    return TaskSubmission(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      submissionUrl: submission,
      isSubmitted: isSubmitted,
      isCorrect: isCorrect,
      points: points,
      feedback: feedback,
    );
  }

  factory TaskSubmission.fromJson(String id, Map<String, dynamic> json) {
    return TaskSubmission(
      id: id,
      taskId: json['taskId'] as String,
      userId: json['userId'] as String,
      submissionUrl: json['submission'],
      isSubmitted: json['isSubmitted'],
      isCorrect: json['isCorrect'],
      points: json['points'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'userId': userId,
      'submission': submissionUrl,
      'isSubmitted': isSubmitted,
      'isCorrect': isCorrect,
      'points': points,
      'feedback': feedback,
    };
  }
}
