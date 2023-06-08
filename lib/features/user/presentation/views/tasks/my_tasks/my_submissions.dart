import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
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
    return submissions.isEmpty
        ? LottieEmpty(message: AppStrings.noSubmissions.tr())
        : ListView.separated(
            itemCount: submissions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final submission = submissions[index];
              final task = tasks.firstWhere(
                (element) => element.id == submission.taskId,
              );
              return SubmissionWidget(
                task: task,
                submission: submission,
              );
            },
          );
  }
}
