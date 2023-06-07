import 'package:flutter/material.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class MyTasksFeedback extends StatelessWidget {
  const MyTasksFeedback({
    super.key,
    required this.tasks,
    required this.submissions,
  });

  final List<Task> tasks;
  final List<TaskSubmission> submissions;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
