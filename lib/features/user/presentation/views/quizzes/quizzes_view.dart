import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/quiz_list_widget.dart';

class QuizzesView extends ConsumerWidget {
  const QuizzesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(quizzesProvider);
    final quizResults = ref.watch(quizResultProvider);
    if (quizzes != null && quizResults != null) {
      quizzes.sort((a, b) => a.id.compareTo(b.id));
      quizResults.sort((a, b) => a.quizId.compareTo(b.quizId));
    }
    return quizzes != null && quizResults != null
        ? quizzes.isEmpty || quizResults.isEmpty
            ? Center(
                child: LottieEmpty(
                  message: AppStrings.noQuizzesFound.tr(),
                ),
              )
            : RefreshIndicator(
                onRefresh: ref.read(quizzesProvider.notifier).getQuizzes,
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
                            return QuizListWidget(
                              quiz: quizzes[index],
                              result: quizResults[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
        : const LottieLoading();
  }
}
