import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
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
    final taskSubmissions = ref.watch(taskSubmissionsProvider);
    final tasksData = ref.watch(tasksProvider);
    List<Task>? tasks;
    tasksData.when(
      data: (data) => tasks = data,
      error: (error, _) => tasks = null,
      loading: () => tasks = null,
    );
    return tasks == null || taskSubmissions == null
        ? const LottieLoading()
        : tasks!.isEmpty && taskSubmissions.isEmpty
            ? LottieEmpty(message: AppStrings.noTasksFound.tr())
            : TasksListWidget(
                tasks: tasks!,
                submissions: taskSubmissions,
                onRefresh: () => ref
                    .read(taskSubmissionsProvider.notifier)
                    .getTaskSubmissions(),
              );
  }
}

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.submissions,
    required this.onRefresh,
  });

  final List<Task> tasks;
  final List<TaskSubmission> submissions;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final taskSubmission = submissions.firstWhere(
                      (element) => element.taskId == task.id,
                      orElse: () => const TaskSubmission(
                        id: "",
                        taskId: "",
                        userId: "",
                        submissionUrl: "",
                      ),
                    );
                    return TaskWidget(
                      task: task,
                      taskSubmission: taskSubmission,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
