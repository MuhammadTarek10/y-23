import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/task_widget.dart';

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
            : buildTasks(ref, tasks, taskSubmissions);
  }

  RefreshIndicator buildTasks(
    WidgetRef ref,
    List<Task> tasks,
    List<TaskSubmission> taskSubmissions,
  ) {
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
          return TaskWidget(
            task: task,
            taskSubmission: taskSubmission,
          );
        },
      ),
    );
  }
}
