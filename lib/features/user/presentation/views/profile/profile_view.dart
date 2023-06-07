import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/media.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';
import 'package:y23/features/auth/state/providers/photo_url_provider.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({super.key});

  final AppPreferences prefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final displayName = ref.watch(userDisplayNameProvider);
    final quizzes = ref.watch(quizzesProvider);
    final quizResults = ref.watch(quizResultProvider);
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;
    final tasks = ref.watch(tasksProvider);
    final submissions = ref.watch(taskSubmissionsProvider);
    final photoUrl = ref.watch(photoUrlProvider);
    return submissions == null ||
            tasks == null ||
            quizzes == null ||
            quizResults == null ||
            displayName == null ||
            userId == null ||
            photoUrl == null
        ? const LottieLoading()
        : ProfileDetails(
            ref: ref,
            userId: userId,
            displayName: displayName,
            photoUrl: photoUrl,
            quizzes: quizzes,
            quizResults: quizResults,
            tasks: tasks,
            submissions: submissions,
            isDarkMode: isDarkMode,
            prefs: prefs,
          );
  }
}

class ProfileDetails extends StatelessWidget {
  ProfileDetails({
    super.key,
    required this.ref,
    required this.userId,
    required this.displayName,
    required this.photoUrl,
    required this.quizzes,
    required this.quizResults,
    required this.tasks,
    required this.submissions,
    required this.isDarkMode,
    required this.prefs,
  });
  final imagePicker = instance<AppMedia>();
  final WidgetRef ref;
  final String userId;
  final String displayName;
  final String photoUrl;
  final List<Quiz> quizzes;
  final List<QuizResult> quizResults;
  final List<Task> tasks;
  final List<TaskSubmission> submissions;
  final bool isDarkMode;
  final AppPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p20),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: AppSizes.s80,
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        final photo = await imagePicker.pickImage();
                        if (photo != null) {
                          ref
                              .read(authStateProvider.notifier)
                              .uploadProfilePicture(
                                userId: userId,
                                photo: File(photo.path),
                              );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(AppSizes.s20),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              displayName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSizes.s30),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.leaderboard_outlined),
                    title: Text(AppStrings.leaderboard.tr()),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.leaderboardRoute,
                    ),
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.check_box_outlined),
                  //   title: Text(AppStrings.myQuizzes.tr()),
                  //   onTap: () => Navigator.pushNamed(
                  //     context,
                  //     Routes.myQuizzesRoute,
                  //   ),
                  // ),
                  ListTile(
                    leading: const Icon(Icons.task_outlined),
                    title: Text(AppStrings.myTasks.tr()),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.myTasksRoute,
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
