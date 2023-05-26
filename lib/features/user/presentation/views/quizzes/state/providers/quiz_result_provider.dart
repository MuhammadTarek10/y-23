import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/notifiers/quiz_results_state_notifier.dart';

final quizResultProvider =
    StateNotifierProvider<QuizResultStateNotifier, List<QuizResult>?>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    if (userId != null) return QuizResultStateNotifier(userId: userId);
    return QuizResultStateNotifier(userId: "");
  },
);
