import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';

import 'state/providers/task_submissions_provider.dart';

class TasksView extends ConsumerWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final taskSubmissions = ref.watch(taskSubmissionsProvider);
    return tasks == null || taskSubmissions == null
        ? const LottieLoading()
        : tasks.isEmpty && taskSubmissions.isEmpty
            ? LottieEmpty(message: AppStrings.noTasksFound.tr())
            : buildTask(ref, tasks, taskSubmissions);
  }

  RefreshIndicator buildTask(
      WidgetRef ref, List<Task> tasks, List<TaskSubmission> taskSubmissions) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(tasksProvider.notifier).getTasks();
        await ref.read(taskSubmissionsProvider.notifier).getTaskSubmissions();
      },
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final taskSubmission = taskSubmissions.firstWhere(
            (element) => element.taskId == task.id,
          );
          return ListTile(
            title: Text(task.title),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.taskRoute,
              arguments: TaskViewParams(
                task: task,
                taskSubmission: taskSubmission,
              ),
            ),
            subtitle: Text(task.description),
            trailing: taskSubmission.isSubmitted == null ||
                    taskSubmission.isSubmitted == false
                ? const Icon(Icons.check_box_outline_blank)
                : const Icon(Icons.check_box),
          );
        },
      ),
    );
  }
}
