import 'package:flutter/material.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/my_tasks/widgets/submission_widget.dart';

class MySubmissions extends StatelessWidget {
  const MySubmissions({
    super.key,
    required this.tasks,
    required this.submissions,
  });

  final List<Task> tasks;
  final List<TaskSubmission> submissions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final task = tasks[index];
        final submission = submissions.firstWhere(
          (element) => element.taskId == task.id,
        );
        return SubmissionWidget(
          task: task,
          submission: submission,
        );
      },
    );
  }
}
