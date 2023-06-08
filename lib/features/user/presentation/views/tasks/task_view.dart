import 'package:flutter/material.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/task_content.dart';
import 'package:y23/features/user/presentation/views/tasks/widgets/task_feedback_button.dart';

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
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p40),
                    child: TaskContent(task: task),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: TaskFeedbackButton(id: task.id, title: task.title),
              ),
            ),
            Positioned(
              left: AppPadding.p0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
