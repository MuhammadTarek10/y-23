import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
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
    return submissions.isEmpty
        ? LottieEmpty(message: AppStrings.noFeedback.tr())
        : ListView.separated(
            itemCount: submissions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final submission = submissions[index];
              final task = tasks.firstWhere(
                (element) => element.id == submission.taskId,
              );
              return FeedbackWidget(
                task: task,
                submission: submission,
              );
            },
          );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.task,
    required this.submission,
  });

  final Task task;
  final TaskSubmission submission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.s10),
          border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Divider(thickness: AppSizes.s4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: submission.feedback!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final feedback = submission.feedback![index];
              return Text(
                feedback,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: null,
              );
            },
          )
        ],
      ),
    );
  }
}
