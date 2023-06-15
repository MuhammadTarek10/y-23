import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:uuid/uuid.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/data/datasources/task_datasource.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';

class RemoteTasker extends TaskDataSource {
  //* Tasks
  @override
  Future<List<Task>?> getTasks() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .get();

    return data.docs.map((e) => Task.fromJson(e.id, e.data())).toList();
  }

  @override
  Future<Task?> getTaskById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .doc(id)
        .get();

    return Task.fromJson(data.id, data.data()!);
  }

  @override
  Future<bool> addOrUpdateTask(Task task) async {
    if (task.id == null) {
      task = task.copyWith(id: const Uuid().v4());
    }
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .doc(task.id)
          .set(task.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
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

  @override
  Future<bool> deleteTask(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tasks)
          .doc(id)
          .delete();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.taskSubmissions)
            .where(FirebaseFieldName.taskSubmissionsTaskId, isEqualTo: id)
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<Task>?> getTasksByUserId(String userId) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .where(FirebaseFieldName.tasksId, isEqualTo: userId)
        .get();

    return data.docs.map((e) => Task.fromJson(e.id, e.data())).toList();
  }

  //* Task Submissions
  @override
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
            element[FirebaseFieldName.taskSubmissionsTaskId] == task.id)) {
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

  @override
  Future<bool> uploadSubmission({
    required String userId,
    required String taskId,
    required File submission,
  }) async {
    try {
      final name = submission.path.split("/").last;
      final path = "${FirebaseFieldName.submission}/$userId/$taskId-$name";

      final data = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.taskSubmissions)
          .where(FirebaseFieldName.taskSubmissionsUserId, isEqualTo: userId)
          .where(FirebaseFieldName.taskSubmissionsTaskId, isEqualTo: taskId)
          .get();

      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(submission).whenComplete(() {});
      final url = await ref.getDownloadURL();

      await data.docs.first.reference.update({
        FirebaseFieldName.submission: url,
        FirebaseFieldName.isTaskSubmitted: true,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<TaskSubmission?> getTaskSubmissionById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .doc(id)
        .get();

    return TaskSubmission.fromJson(data.id, data.data()!);
  }

  @override
  Future<List<TaskSubmission>?> getTaskSubmissions() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.taskSubmissions)
        .get();

    return data.docs
        .map((e) => TaskSubmission.fromJson(e.id, e.data()))
        .toList();
  }
}
