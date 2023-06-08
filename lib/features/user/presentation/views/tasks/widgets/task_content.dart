import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/upload_task_button.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      ? InkWell(
                          onTap: () async {
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
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  AppStrings.details.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                                const SizedBox(width: AppSizes.s4),
                                Icon(
                                  Icons.more_outlined,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.s20),
            UploadTaskButton(task: task),
          ],
        ),
      ),
    );
  }
}
