import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/quiz_list_widget.dart';

class QuizzesView extends ConsumerWidget {
  const QuizzesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(quizzesProvider);
    final quizResults = ref.watch(quizResultProvider);
    return quizzes != null && quizResults != null
        ? quizzes.isEmpty || quizResults.isEmpty
            ? Center(
                child: LottieEmpty(
                  message: AppStrings.noQuizzesFound.tr(),
                ),
              )
            : buildQuiz(ref, quizzes, quizResults)
        : const LottieLoading();
  }

  RefreshIndicator buildQuiz(
      WidgetRef ref, List<Quiz> quizzes, List<QuizResult> quizResults) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(quizzesProvider.notifier).getQuizzes();
        await ref.read(quizResultProvider.notifier).getQuizResults();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quizzes.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    final quizResult = quizResults.firstWhere(
                        (element) => element.quizId == quizzes[index].id);
                    return QuizListWidget(quiz: quiz, result: quizResult);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
