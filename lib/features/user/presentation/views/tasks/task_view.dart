import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/presentation/views/feedback/feedback_view_params.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/upload_task_button.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.params,
  });

  final TaskViewParams params;

  @override
  Widget build(BuildContext context) {
    final task = params.task;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.s10),
                ),
                child: Column(
                  children: [
                    Text(
                      task.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSizes.s20),
                    task.documentationLink != null &&
                            task.documentationLink!.isNotEmpty
                        ? SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async {
                                final url = Uri.parse(task.documentationLink!);
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url);
                                } else {
                                  if (context.mounted) {
                                    customShowSnackBar(
                                      context: context,
                                      message: AppStrings.problemWithLink.tr(),
                                      isError: true,
                                    );
                                  }
                                }
                              },
                              child: Text(AppStrings.details.tr()),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.s20),
              const UploadTaskButton(),
              FeedbackWidget(id: task.id, title: task.title),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackWidget extends ConsumerWidget {
  const FeedbackWidget({
    super.key,
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: AppSizes.s20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.wantToAddFeedback.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: AppSizes.s10),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  Routes.feedbackRoute,
                  arguments: FeedbackViewParams(
                    title: title,
                    onPressed: (feedback) =>
                        sendFeedback(context, ref, feedback, id),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.s10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.addFeedback.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontStyle: FontStyle.normal),
                        ),
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> sendFeedback(
    BuildContext context,
    WidgetRef ref,
    String feedback,
    String id,
  ) async {
    ref.read(loadingProvider.notifier).loading();
    await ref.read(taskSubmissionsProvider.notifier).sendFeedback(
          id: id,
          feedback: feedback,
        );
    ref.read(loadingProvider.notifier).doneLoading();
    if (context.mounted) {
      customShowSnackBar(
        context: context,
        message: AppStrings.feedbackAdded.tr(),
      );
      Navigator.pop(context);
    }
  }
}
