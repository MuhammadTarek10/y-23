import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/domain/repositories/task_repository.dart';

class TaskSubmissionsStateNotifier
    extends StateNotifier<List<TaskSubmission>?> {
  final taskRepo = instance<TaskRepository>();
  final String userId;
  TaskSubmissionsStateNotifier({required this.userId}) : super(null) {
    getTaskSubmissions();
  }

  Future<void> getTaskSubmissions() async {
    state = await taskRepo.getTaskSubmissionsByUserId(userId);
  }

  Future<bool> uploadSubmission({
    required String userId,
    required String taskId,
    required File submission,
  }) async {
    bool result = false;
    await taskRepo
        .uploadSubmission(
      userId: userId,
      taskId: taskId,
      submission: submission,
    )
        .then((value) async {
      await getTaskSubmissions();
      result = value;
    });
    return result;
  }

  Future<void> sendFeedback({
    required String id,
    required String feedback,
  }) async {
    await taskRepo.sendFeedback(
      id,
      feedback,
    );
  }

  Future<void> addOrUpdateTask(Task task) async {
    await taskRepo.addOrUpdateTask(task);
    getTaskSubmissions();
  }


  Future<void> deleteTask(Task task) async {
    await taskRepo.deleteTask(task.id!);
    getTaskSubmissions();
  }
}
