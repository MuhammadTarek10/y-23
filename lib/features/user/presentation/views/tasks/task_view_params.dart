import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

@immutable
class TaskViewParams {
  const TaskViewParams({
    required this.task,
    required this.taskSubmission,
  });

  final Task task;
  final TaskSubmission? taskSubmission;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskViewParams &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          taskSubmission == other.taskSubmission;

  @override
  int get hashCode => task.hashCode ^ taskSubmission.hashCode;

  @override
  String toString() =>
      'TaskViewParams{task: $task, taskSubmission: $taskSubmission}';
}
