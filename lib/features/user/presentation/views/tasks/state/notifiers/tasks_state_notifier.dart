import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/tasker.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';

class TasksStateNotifier extends StateNotifier<List<Task>?> {
  final tasker = const Tasker();
  TasksStateNotifier() : super(null) {
    getTasks();
  }

  Future<void> getTasks() async {
    final tasks = await tasker.getTasks();
    if (tasks != null) tasks.sort((a, b) => a.title.compareTo(b.title));
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    final isSuccess = await tasker.addTask(task);
    if (isSuccess) getTasks();
  }

  Future<void> deleteTask(String id) async {
    final isSuccess = await tasker.deleteTask(id);
    if (isSuccess) getTasks();
  }

  Future<void> updateTask(Task task) async {
    final isSuccess = await tasker.updateTask(task);
    if (isSuccess) getTasks();
  }

  Future<void> sendFeedback(String id, String feedback) async {
    final isSuccess = await tasker.sendFeedback(id, feedback);
    if (isSuccess) getTasks();
  }

  Future<void> getTaskById(String id) async {
    final task = await tasker.getTaskById(id);
    state = [task!];
  }

  Future<void> getTasksByUserId(String userId) async {
    final tasks = await tasker.getTasksByUserId(userId);
    state = tasks;
  }
}
