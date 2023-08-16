import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class SubmissionWidget extends StatelessWidget {
  const SubmissionWidget({
    super.key,
    required this.task,
    required this.submission,
  });

  final Task task;
  final TaskSubmission submission;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final url = Uri.parse(submission.submissionUrl ?? "");
        if (await canLaunchUrl(url)) {
          // ignore: deprecated_member_use
          launch(submission.submissionUrl ?? "");
        }
      },
      leading: Text(
        task.title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: AppColors.fakeWhite),
      ),
      trailing: submission.isSubmitted != null && submission.isSubmitted!
          ? const Icon(Icons.arrow_forward_ios)
          : const Icon(Icons.close),
    );
  }
}
