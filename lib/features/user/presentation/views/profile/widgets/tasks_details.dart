import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class TasksDetails extends StatelessWidget {
  const TasksDetails({
    super.key,
    required this.tasks,
    required this.submissions,
    required this.onPressed,
  });

  final List<Task> tasks;
  final List<TaskSubmission> submissions;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final submits = submissions
        .map((submission) => submission.isSubmitted == true ? 1 : 0)
        .reduce(
          (value, element) => value + element,
        );
    final corrects = submissions
        .map((submission) => submission.isCorrect == true ? 1 : 0)
        .reduce(
          (value, element) => value + element,
        );
    final subPoints = submissions
        .map((e) => e.points ?? 0)
        .reduce((value, element) => value + element);
    final tasksPoints = tasks
        .map((e) => e.points ?? 0)
        .reduce((value, element) => value + element);
    final good = tasksPoints == 0 || subPoints / tasksPoints > 0.5;
    const int zero = 0;
    final totalPoints = tasks
        .map((task) => task.points ?? zero)
        .reduce((value, element) => value + element)
        .toString();
    final points = submissions
        .map((task) => task.points ?? zero)
        .reduce((value, element) => value + element)
        .toString();
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                AppStrings.tasksSubmitted.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                submits.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                AppStrings.tasksCorrect.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                corrects.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                AppStrings.score.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.s4),
              Text(
                "$points/$totalPoints",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: good
                          ? const Color.fromARGB(255, 45, 194, 50)
                          : const Color.fromARGB(255, 181, 63, 54),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
