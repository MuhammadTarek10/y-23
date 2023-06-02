import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view_params.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/question_widget.dart';

class QuizView extends ConsumerWidget {
  const QuizView({
    super.key,
    required this.params,
  });

  final QuizViewParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = params.quiz;
    final result = params.result;
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quiz.questions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  String selectedOption =
                      result.selectedOptions[question.title] ?? "";
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return QuestionWidget(
                        question: question,
                        selectedOption: selectedOption,
                        onPressed: (option) {
                          result.selectedOptions[question.title] = option;
                          setState(() {
                            selectedOption = option;
                          });
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: AppSizes.s10),
              buildSubmitSection(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSubmitSection(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
          ),
          child: Text(AppStrings.areYouSure.tr()),
        ),
        Expanded(
          child: InkWell(
            onTap: () => submit(context, ref),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p10),
              margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(AppSizes.s10),
              ),
              child: Center(
                child: Text(
                  AppStrings.submit.tr(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> submit(BuildContext context, WidgetRef ref) async {
    // check if all questions are answered
    final quiz = params.quiz;
    final result = params.result;
    if (quiz.questions.length != result.selectedOptions.length) {
      customShowSnackBar(
        context: context,
        message: AppStrings.answerAllQuestions.tr(),
        isError: true,
      );
    } else {
      ref.read(loadingProvider.notifier).loading();
      final userId = ref.read(userIdProvider) as String;

      final quizId = quiz.id;
      final totalQuestions = quiz.questions.length;

      final selectedOptions = result.selectedOptions;

      final score = quiz.questions
          .where(
              (question) => question.answer == selectedOptions[question.title])
          .length;

      await ref.read(quizResultProvider.notifier).saveQuizResult(
            userId: userId,
            quizId: quizId,
            score: score,
            selectedOptions: selectedOptions,
            totalQuestions: totalQuestions,
          );
      ref.read(loadingProvider.notifier).doneLoading();
      if (context.mounted) {
        customShowSnackBar(
          context: context,
          message: AppStrings.quizSubmitted.tr(),
        );
        Navigator.pop(context);
      }
    }
  }
}
