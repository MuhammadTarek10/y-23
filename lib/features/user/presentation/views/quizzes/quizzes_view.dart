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
    final results = ref.watch(quizResultsProvider);

    return results == null
        ? const LottieLoading()
        : Center(
            child: quizzes.when(
              data: (data) {
                if (data == null || data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieEmpty(message: AppStrings.noQuizzesFound.tr()),
                    ],
                  );
                }
                return QuizzesWidget(
                  quizzes: data,
                  results: results,
                );
              },
              error: (error, _) => const LottieError(),
              loading: () => const LottieLoading(),
            ),
          );
  }
}

class QuizzesWidget extends StatelessWidget {
  const QuizzesWidget({
    super.key,
    required this.quizzes,
    required this.results,
  });

  final List<Quiz> quizzes;
  final List<QuizResult> results;

  @override
  Widget build(BuildContext context) {
    final taken = results.where((element) => element.isTaken).toList();
    final notTaken = results.where((element) => !element.isTaken).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.onSecondary,
            tabs: [
              Tab(text: AppStrings.available.tr()),
              Tab(text: AppStrings.taken.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Quizzes(
              quizzes: notTaken
                  .map((e) =>
                      quizzes.firstWhere((element) => element.id == e.quizId))
                  .toList(),
              results: results,
            ),
            Quizzes(
              quizzes: taken
                  .map((e) =>
                      quizzes.firstWhere((element) => element.id == e.quizId))
                  .toList(),
              results: results,
            ),
          ],
        ),
      ),
    );
  }
}

class Quizzes extends StatelessWidget {
  const Quizzes({
    super.key,
    required this.quizzes,
    required this.results,
  });

  final List<Quiz> quizzes;
  final List<QuizResult> results;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = quizzes[index];
                  final quizResult = results.firstWhere(
                      (element) => element.quizId == quizzes[index].id,
                      orElse: () => QuizResult(
                            userId: "",
                            quizId: "",
                            isTaken: false,
                            selectedOptions: {},
                            score: 0,
                            isPassed: false,
                          ));
                  return QuizListWidget(quiz: quiz, result: quizResult);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
