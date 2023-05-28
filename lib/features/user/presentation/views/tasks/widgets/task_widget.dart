import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.taskSubmission,
  });

  final Task task;
  final TaskSubmission taskSubmission;

  @override
  Widget build(BuildContext context) {
    final isSubmitted = taskSubmission.isSubmitted ?? false;
    final isCorrect = taskSubmission.isCorrect ?? false;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.taskRoute,
        arguments: TaskViewParams(
          task: task,
          taskSubmission: taskSubmission,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSubmitted
                  ? isCorrect
                      ? Colors.green
                      : Colors.red
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(AppSizes.s10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      child: Text(
                        task.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      child: Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Row(
                  children: [
                    Text(
                      isSubmitted
                          ? isCorrect
                              ? AppStrings.correct.tr()
                              : AppStrings.incorrect.tr()
                          : AppStrings.notSubmitted.tr(),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: isSubmitted
                                    ? isCorrect
                                        ? Colors.green
                                        : Colors.red
                                    : Colors.grey,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
