import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/domain/entities/tasks/task.dart';

@immutable
class TaskViewParams {
  const TaskViewParams({
    required this.task,
  });

  final Task task;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskViewParams &&
          runtimeType == other.runtimeType &&
          task == other.task;

  @override
  @override
  String toString() => 'TaskViewParams{task: $task}';

  @override
  int get hashCode => task.hashCode;
}
