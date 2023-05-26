import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.read(userDisplayNameProvider);
    final quizResults = ref.watch(quizResultProvider);
    return quizResults == null || displayName == null
        ? const LottieLoading()
        : Container(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    displayName.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSizes.s28),
                  QuizzesDetails(quizResults: quizResults),
                ],
              ),
            ),
          );
  }
}

class QuizzesDetails extends StatelessWidget {
  const QuizzesDetails({
    super.key,
    required this.quizResults,
  });

  final List<QuizResult> quizResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              AppStrings.quizzesTaken.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.s4),
            Text(
              quizResults
                  .map((result) => (result.isTaken ? 1 : 0))
                  .reduce((value, element) => value + element)
                  .toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              AppStrings.quizzesPassed.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.s4),
            Text(
              quizResults
                  .map((result) => (result.isPassed ? 1 : 0))
                  .reduce((value, element) => value + element)
                  .toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              AppStrings.score.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.s4),
            Text(
              quizResults
                  .map((result) => (result.score))
                  .reduce((value, element) => value + element)
                  .toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
