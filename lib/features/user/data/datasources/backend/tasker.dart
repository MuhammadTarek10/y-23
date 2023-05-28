import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class Tasker {
  const Tasker();

  //* Tasks

  Future<List<Task>?> getTasks() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .get();

    return data.docs.map((e) => Task.fromJson(e.id, e.data())).toList();
  }

  Future<Task?> getTaskById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .doc(id)
        .get();

    return Task.fromJson(data.id, data.data()!);
  }

  Future<bool> addTask(Task task) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .add(task.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> sendFeedback(String id, String feedback) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .doc(id)
          .update({
        FirebaseFieldName.tasksFeedback: FieldValue.arrayUnion([feedback])
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .doc(id)
          .delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .doc(task.id)
          .update(task.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<Task>?> getTasksByUserId(String userId) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .where(FirebaseFieldName.tasksId, isEqualTo: userId)
        .get();

    return data.docs.map((e) => Task.fromJson(e.id, e.data())).toList();
  }

  //* Task Submissions

  Future<List<TaskSubmission>?> getTaskSubmissionsByUserId(
      String userId) async {
    final taskSubmissions = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .where(FirebaseFieldName.taskSubmissionsUserId, isEqualTo: userId)
        .get();

    final tasks = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .get();

    if (taskSubmissions.docs.length < tasks.docs.length) {
      for (final task in tasks.docs) {
        if (!taskSubmissions.docs.any((element) =>
            element[FirebaseFieldName.taskSubmissionsTaskId] ==
            task[FirebaseFieldName.tasksId])) {
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.taskSubmissions)
              .add({
            FirebaseFieldName.taskSubmissionsUserId: userId,
            FirebaseFieldName.taskSubmissionsTaskId: task.id,
          });
        }
      }

      return getTaskSubmissionsByUserId(userId);
    }

    return taskSubmissions.docs
        .map((e) => TaskSubmission.fromJson(e.id, e.data()))
        .toList();
  }

  Future<bool> saveTaskSubmission({
    required String userId,
    required String taskId,
    required dynamic submission,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.taskSubmissions)
          .doc(taskId)
          .update({
        FirebaseFieldName.taskSubmissionsSubmission: submission,
        FirebaseFieldName.taskSubmissionsIsSubmitted: true,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> updateTaskSubmission({
    required String id,
    required dynamic submission,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .doc(id)
        .update({
      FirebaseFieldName.taskSubmissionsSubmission: submission,
      FirebaseFieldName.taskSubmissionsIsSubmitted: true,
    });
  }

  Future<void> submitTask({
    required String id,
    required dynamic submission,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .doc(id)
        .update({
      FirebaseFieldName.taskSubmissionsSubmission: submission,
      FirebaseFieldName.taskSubmissionsIsSubmitted: true,
    });
  }

  Future<TaskSubmission?> getTaskSubmissionById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .doc(id)
        .get();

    return TaskSubmission.fromJson(data.id, data.data()!);
  }

  Future<List<TaskSubmission>?> getTaskSubmissions() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .get();

    return data.docs
        .map((e) => TaskSubmission.fromJson(e.id, e.data()))
        .toList();
  }
}
