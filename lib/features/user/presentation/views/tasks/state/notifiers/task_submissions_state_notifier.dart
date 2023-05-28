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

  Future<void> saveTaskSubmission({
    required String userId,
    required String taskId,
    required dynamic submission,
  }) async {
    await tasker.saveTaskSubmission(
      userId: userId,
      taskId: taskId,
      submission: submission,
    );
    await getTaskSubmissions();
  }

  Future<void> updateTaskSubmission({
    required String id,
    required dynamic submission,
  }) async {
    await tasker.updateTaskSubmission(
      id: id,
      submission: submission,
    );
    await getTaskSubmissions();
  }

  Future<void> submitTaskSubmission({
    required String id,
    required dynamic submission,
  }) async {
    await tasker.submitTask(
      id: id,
      submission: submission,
    );
    await getTaskSubmissions();
  }
}
