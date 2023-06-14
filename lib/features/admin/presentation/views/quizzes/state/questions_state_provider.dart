import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:y23/features/admin/presentation/views/quizzes/state/questions_state_notifier.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

final questionsProvider =
    StateNotifierProvider<QuestionsStateNotifier, List<Question>?>(
  (_) => QuestionsStateNotifier(),
);
