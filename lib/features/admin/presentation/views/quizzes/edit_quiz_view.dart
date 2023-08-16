import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';

class EditQuizVew extends ConsumerWidget {
  const EditQuizVew({super.key});

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
          title: Text(AppStrings.editQuiz.tr()),
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
                    Routes.addQuizRoute,
                    arguments: quiz,
                  ),
                  trailing: const Icon(Icons.edit),
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
}
