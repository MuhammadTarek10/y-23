import 'dart:io';

import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

abstract class TaskDataSource {
  //* Tasks
  Future<List<Task>?> getTasks();
  Future<Task?> getTaskById(String id);
  Future<bool> addOrUpdateTask(Task task);
  Future<bool> deleteTask(String id);
  Future<bool> sendFeedback(String id, String feedback);
  Future<List<Task>?> getTasksByUserId(String userId);

  //* Submissions
  Future<List<TaskSubmission>?> getTaskSubmissions();
  Future<List<TaskSubmission>?> getTaskSubmissionsByUserId(String userId);
  Future<TaskSubmission?> getTaskSubmissionById(String id);
  Future<bool> uploadSubmission({
    required String userId,
    required String taskId,
    required File submission,
  });
}
