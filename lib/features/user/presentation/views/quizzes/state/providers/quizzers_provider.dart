import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/notifiers/quizzes_state_notifier.dart';

final quizzesProvider = StateNotifierProvider<QuizzesStateNotifier, List<Quiz>>(
  (_) => QuizzesStateNotifier(),
);
