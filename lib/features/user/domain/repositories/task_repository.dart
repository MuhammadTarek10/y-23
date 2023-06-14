import 'dart:io';

import 'package:y23/features/user/data/datasources/backend/tasker.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class TaskRepository {
  final RemoteTasker remoteTasker;
  const TaskRepository({required this.remoteTasker});

  //* Tasks
  Future<List<Task>?> getTasks() async {
    return await remoteTasker.getTasks();
  }

  Future<Task?> getTaskById(String id) async {
    return await remoteTasker.getTaskById(id);
  }

  Future<List<Task>?> getTasksByUserId(String userId) async {
    return await remoteTasker.getTasksByUserId(userId);
  }

  Future<bool> addOrUpdateTask(Task task) async {
    return await remoteTasker.addOrUpdateTask(task);
  }

  Future<bool> sendFeedback(String id, String feedback) async {
    return await remoteTasker.sendFeedback(id, feedback);
  }

  Future<bool> deleteTask(String id) async {
    return await remoteTasker.deleteTask(id);
  }

  //* Submissions
  Future<List<TaskSubmission>?> getTaskSubmissions() async {
    return await remoteTasker.getTaskSubmissions();
  }

  Future<List<TaskSubmission>?> getTaskSubmissionsByUserId(
      String userId) async {
    return await remoteTasker.getTaskSubmissionsByUserId(userId);
  }

  Future<TaskSubmission?> getTaskSubmissionById(String id) async {
    return await remoteTasker.getTaskSubmissionById(id);
  }

  Future<bool> uploadSubmission({
    required String userId,
    required String taskId,
    required File submission,
  }) async {
    return await remoteTasker.uploadSubmission(
      userId: userId,
      taskId: taskId,
      submission: submission,
    );
  }
}
