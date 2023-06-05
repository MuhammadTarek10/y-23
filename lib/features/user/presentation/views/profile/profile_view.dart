import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/presentation/views/home/state/providers/bottom_navigation_provider.dart';
import 'package:y23/features/user/presentation/views/profile/widgets/quizzes_details.dart';
import 'package:y23/features/user/presentation/views/profile/widgets/tasks_details.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({super.key});

  final AppPreferences prefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.read(userDisplayNameProvider);
    final quizzes = ref.watch(quizzesProvider);
    final quizResults = ref.watch(quizResultProvider);
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;
    final tasks = ref.watch(tasksProvider);
    final submissions = ref.watch(taskSubmissionsProvider);
    return submissions == null ||
            tasks == null ||
            quizzes == null ||
            quizResults == null ||
            displayName == null
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
                  const SizedBox(height: AppSizes.s30),
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QuizzesDetails(
                                quizzes: quizzes,
                                quizResults: quizResults,
                                onPressed: () => ref
                                    .read(bottomNavigationProvider.notifier)
                                    .immediateChange(
                                        BottomNavigationOptions.quizzes),
                              ),
                              const Divider(),
                              TasksDetails(
                                tasks: tasks,
                                submissions: submissions,
                                onPressed: () => ref
                                    .read(bottomNavigationProvider.notifier)
                                    .immediateChange(
                                        BottomNavigationOptions.tasks),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.task_outlined),
                          title: Text(AppStrings.myTasks.tr()),
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.myTasksRoute,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.feedback_outlined),
                          title: Text(AppStrings.tasksFeedback.tr()),
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.tasksFeedbackRoute,
                          ),
                        ),
                        const Divider(),
                        // ListTile(
                        //   leading: const Icon(Icons.settings_outlined),
                        //   title: Text(AppStrings.settings.tr()),
                        //   onTap: () => Navigator.pushNamed(
                        //     context,
                        //     Routes.settingsRoute,
                        //   ),
                        // ),
                        ListTile(
                          leading: const Icon(Icons.help_outline),
                          title: Text(AppStrings.help.tr()),
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.helpRoute,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            isDarkMode
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                          ),
                          title: Text(
                            !isDarkMode
                                ? AppStrings.lightMode.tr()
                                : AppStrings.darkMode.tr(),
                          ),
                          onTap: () {
                            prefs.toggleTheme();
                            ref.read(themeProvider.notifier).toggleTheme();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.language_outlined),
                          title: Text(AppStrings.language.tr()),
                          onTap: () {
                            prefs.toggleLanguage();
                            Phoenix.rebirth(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
