import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/admin/presentation/views/stats/state/providers/users_provider.dart';
import 'package:y23/features/admin/presentation/views/stats/widgets/stats_widget.dart';
import 'package:y23/features/admin/presentation/views/stats/widgets/users_list_widget.dart';
import 'package:y23/features/auth/domain/entities/user.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quizzers_provider.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class StatsView extends ConsumerWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsStream = ref.watch(sessionProvider);
    List<Session>? sessions;
    sessionsStream.when(
      data: (data) => sessions = data,
      loading: () {},
      error: (error, stackTrace) {},
    );

    final quizzesStream = ref.watch(quizzesProvider);
    List<Quiz>? quizzes;
    quizzesStream.when(
      data: (data) => quizzes = data,
      loading: () {},
      error: (error, stackTrace) {},
    );

    final tasksStream = ref.watch(tasksProvider);
    List<Task>? tasks;
    tasksStream.when(
      data: (data) => tasks = data,
      loading: () {},
      error: (error, stackTrace) {},
    );

    final usersStream = ref.watch(usersProvider);
    List<User>? users = [];
    List<User>? admins = [];
    usersStream.when(
      data: (data) {
        users = data.where((element) => element.isAdmin == false).toList();
        admins = data.where((element) => element.isAdmin == true).toList();
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
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
          title: Text(AppStrings.stats.tr()),
        ),
        body: SafeArea(
          child: sessions == null ||
                  quizzes == null ||
                  tasks == null ||
                  users == null ||
                  admins == null
              ? const LottieLoading()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      StatsWidget(
                        sessions: sessions!,
                        tasks: tasks!,
                        quizzes: quizzes!,
                      ),
                      const Divider(),
                      UsersListWidget(
                        users: users!,
                        admins: admins!,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
