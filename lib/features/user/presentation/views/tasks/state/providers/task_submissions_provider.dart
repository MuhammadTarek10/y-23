import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/state/notifiers/task_submissions_state_notifier.dart';

final taskSubmissionsProvider =
    StateNotifierProvider<TaskSubmissionsStateNotifier, List<TaskSubmission>?>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    if (userId != null) return TaskSubmissionsStateNotifier(userId: userId);
    return TaskSubmissionsStateNotifier(userId: "");
  },
);
