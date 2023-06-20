import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/task_widget.dart';

import 'state/providers/task_submissions_provider.dart';

class TasksView extends ConsumerWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksData = ref.watch(tasksProvider);
    List<Task>? tasks;
    tasksData.when(
      data: (data) => tasks = data,
      error: (error, _) => tasks = null,
      loading: () => tasks = null,
    );
    return tasks == null
        ? const LottieLoading()
        : tasks!.isEmpty
            ? LottieEmpty(message: AppStrings.noTasksFound.tr())
            : TasksListWidget(
                tasks: tasks!,
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
    required this.onRefresh,
  });

  final List<Task> tasks;
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
                    return TaskWidget(
                      task: task,
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
