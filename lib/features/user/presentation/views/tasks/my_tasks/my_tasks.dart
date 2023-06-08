import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/tasks/my_tasks/my_submissions.dart';
import 'package:y23/features/user/presentation/views/tasks/my_tasks/tasks_feedback.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class MyTasksView extends ConsumerStatefulWidget {
  const MyTasksView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTasksViewState();
}

class _MyTasksViewState extends ConsumerState<MyTasksView> {
  @override
  Widget build(BuildContext context) {
    final submissions = ref.watch(taskSubmissionsProvider);
    final tasks = ref.watch(tasksProvider);

    return tasks == null || submissions == null
        ? const LottieLoading()
        : DefaultTabController(
            length: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.onSecondary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(AppStrings.myTasks.tr()),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await ref.read(tasksProvider.notifier).getTasks();
                        await ref
                            .read(taskSubmissionsProvider.notifier)
                            .getTaskSubmissions();
                      },
                      icon: const Icon(Icons.refresh_outlined),
                    ),
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(text: AppStrings.tasks.tr()),
                      Tab(text: AppStrings.tasksFeedback.tr()),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    MySubmissions(
                      tasks: tasks,
                      submissions: submissions
                          .where((element) => element.isSubmitted == true)
                          .toList(),
                    ),
                    MyTasksFeedback(
                      tasks: tasks,
                      submissions: submissions
                          .where((element) => element.feedback != null)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
