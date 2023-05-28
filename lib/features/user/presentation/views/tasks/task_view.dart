import 'package:flutter/material.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.params,
  });

  final TaskViewParams params;

  @override
  Widget build(BuildContext context) {
    final task = params.task;
    final taskSubmission = params.taskSubmission;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Text(task.description),
                const SizedBox(height: 10),
                Text(taskSubmission.isSubmitted == null ||
                        taskSubmission.isSubmitted == false
                    ? "Not Submitted"
                    : "Submitted"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
