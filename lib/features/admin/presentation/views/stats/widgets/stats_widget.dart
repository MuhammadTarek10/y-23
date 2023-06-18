import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.sessions,
    required this.tasks,
    required this.quizzes,
  });

  final List<Session> sessions;
  final List<Task> tasks;
  final List<Quiz> quizzes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppStrings.sessions.tr()} | ${AppStrings.tasks.tr()} | ${AppStrings.quizzes.tr()}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppPadding.p4),
        Row(
          children: [
            Stats(title: AppStrings.sessions.tr(), list: sessions),
            Stats(title: AppStrings.tasks.tr(), list: tasks),
            Stats(title: AppStrings.quizzes.tr(), list: quizzes),
          ],
        ),
      ],
    );
  }
}

class Stats extends StatelessWidget {
  const Stats({
    super.key,
    required this.title,
    required this.list,
  });

  final String title;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(AppSizes.s10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.fakeWhite,
                      fontSize: context.width * 0.035,
                    ),
              ),
              Text(
                '${list.length}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.fakeWhite,
                      fontSize: context.width * 0.035,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
