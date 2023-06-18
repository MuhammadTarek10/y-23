import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view_params.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';

class DeleteQuizView extends ConsumerWidget {
  const DeleteQuizView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(quizzesProvider);
    return Container(
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
        appBar: AppBar(
          title: Text(AppStrings.deleteQuiz.tr()),
        ),
        body: quizzes.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return LottieEmpty(message: AppStrings.noTasksFound.tr());
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final quiz = data.elementAt(index);
                return ListTile(
                  title: Text(data[index].title),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.quizzesRoute,
                    arguments: QuizViewParams(
                      quiz: quiz,
                      result: null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final result = await confirmationDialog(context);
                      if (result == true) {
                        ref.read(loadingProvider.notifier).loading();
                        final result = await ref
                            .read(quizResultsProvider.notifier)
                            .deleteQuiz(quiz);
                        ref.read(loadingProvider.notifier).doneLoading();
                        if (context.mounted) {
                          if (result) {
                            customShowSnackBar(
                              context: context,
                              message: AppStrings.done.tr(),
                            );
                          } else {
                            customShowSnackBar(
                              context: context,
                              message: AppStrings.generalError.tr(),
                              isError: true,
                            );
                          }
                        }
                      }
                    },
                  ),
                );
              },
            );
          },
          error: (error, _) => const LottieError(),
          loading: () => const LottieLoading(),
        ),
      ),
    );
  }

  Future<bool?> confirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: AppColors.fakeWhite,
        title: Text(
          AppStrings.deleteQuiz.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
              ),
        ),
        content: Text(
          AppStrings.deleteQuizConfirmation.tr(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppStrings.yes.tr()),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: Text(AppStrings.no.tr()),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );
  }
}
