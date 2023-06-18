import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/performance/my_submissions.dart';
import 'package:y23/features/user/presentation/views/tasks/performance/tasks_feedback.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class PerformanceView extends ConsumerStatefulWidget {
  const PerformanceView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTasksViewState();
}

class _MyTasksViewState extends ConsumerState<PerformanceView> {
  @override
  Widget build(BuildContext context) {
    final submissions = ref.watch(taskSubmissionsProvider);
    final tasksStream = ref.watch(tasksProvider);
    List<Task>? tasks;
    tasksStream.when(
      data: (data) => tasks = data,
      error: (error, _) {},
      loading: () {},
    );
    final quizResults = ref.watch(quizResultsProvider);
    final quizStream = ref.watch(quizzesProvider);
    List<Quiz>? quizzes;
    quizStream.when(
      data: (data) => quizzes = data,
      error: (error, _) {},
      loading: () {},
    );

    return tasks == null ||
            submissions == null ||
            quizzes == null ||
            quizResults == null
        ? const LottieLoading()
        : DefaultTabController(
            length: 3,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.onSecondary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(AppStrings.performance.tr()),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: AppStrings.quizzes.tr()),
                      Tab(text: AppStrings.tasks.tr()),
                      Tab(text: AppStrings.tasksFeedback.tr()),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    MyQuizzes(
                        quizzes: quizzes!,
                        quizResults: quizResults
                            .where((element) => element.isTaken == true)
                            .toList()),
                    MySubmissions(
                      tasks: tasks!,
                      submissions: submissions
                          .where((element) => element.isSubmitted == true)
                          .toList(),
                    ),
                    MyTasksFeedback(
                      tasks: tasks!,
                      submissions: submissions
                          .where((element) => element.feedback != null)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class MyQuizzes extends StatelessWidget {
  const MyQuizzes({
    super.key,
    required this.quizzes,
    required this.quizResults,
  });

  final List<Quiz> quizzes;
  final List<QuizResult> quizResults;

  String _totalScore() {
    return "${quizResults.map((e) => e.score).reduce((value, element) => value + element)} / ${quizzes.map((e) => e.questions.length).reduce((value, element) => value + element)}";
  }

  double _totalPercentage() {
    return (quizResults
                .map((e) => e.score)
                .reduce((value, element) => value + element) /
            quizzes
                .map((e) => e.questions.length)
                .reduce((value, element) => value + element)) *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return quizResults.isEmpty
        ? LottieEmpty(message: AppStrings.noQuizzesFound.tr())
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.totalScore.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "${_totalPercentage()} %",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          _totalScore(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.name.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        AppStrings.score.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quizResults.length,
                  itemBuilder: (context, index) {
                    final result = quizResults[index];
                    final quiz = quizzes.firstWhere(
                      (element) => element.id == result.quizId,
                    );
                    return ListTile(
                      leading: result.isPassed
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close),
                      title: Text(
                        quiz.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Text(
                        "${result.score} / ${quiz.questions.length}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
