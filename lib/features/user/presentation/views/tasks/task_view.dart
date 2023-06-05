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
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.s10),
                  ),
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
        ],
      ),
    );
  }
}
