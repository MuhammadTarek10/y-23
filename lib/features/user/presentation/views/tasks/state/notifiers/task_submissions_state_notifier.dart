import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/tasker.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class TaskSubmissionsStateNotifier
    extends StateNotifier<List<TaskSubmission>?> {
  final tasker = const Tasker();
  final String userId;
  TaskSubmissionsStateNotifier({required this.userId}) : super(null) {
    getTaskSubmissions();
  }

  Future<void> getTaskSubmissions() async {
    state = await tasker.getTaskSubmissionsByUserId(userId);
  }

  Future<bool> uploadSubmission({
    required String userId,
    required String taskId,
    required File submission,
  }) async {
    bool result = false;
    await tasker
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
    await tasker.sendFeedback(
      id,
      feedback,
    );
    await getTaskSubmissions();
  }
}
