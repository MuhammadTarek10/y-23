import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/repositories/task_repository.dart';

class TasksStateNotifier extends StateNotifier<List<Task>?> {
  final taskRepo = instance<TaskRepository>();
  TasksStateNotifier() : super(null) {
    getTasks();
  }

  Future<void> getTasks() async {
    final tasks = await taskRepo.getTasks();
    if (tasks != null) tasks.sort((a, b) => a.title.compareTo(b.title));
    state = tasks;
  }

  Future<void> addTask(Task task) async {
    final isSuccess = await taskRepo.addOrUpdateTask(task);
    if (isSuccess) getTasks();
  }

  Future<void> deleteTask(String id) async {
    final isSuccess = await taskRepo.deleteTask(id);
    if (isSuccess) getTasks();
  }

  Future<void> sendFeedback(String id, String feedback) async {
    final isSuccess = await taskRepo.sendFeedback(id, feedback);
    if (isSuccess) getTasks();
  }

  Future<void> getTaskById(String id) async {
    final task = await taskRepo.getTaskById(id);
    state = [task!];
  }

  Future<void> getTasksByUserId(String userId) async {
    final tasks = await taskRepo.getTasksByUserId(userId);
    state = tasks;
  }
}
