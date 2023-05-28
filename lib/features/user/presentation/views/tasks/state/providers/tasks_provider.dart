import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/tasks/state/notifiers/tasks_state_notifier.dart';

final tasksProvider = StateNotifierProvider<TasksStateNotifier, List<Task>?>(
  (_) => TasksStateNotifier(),
);
