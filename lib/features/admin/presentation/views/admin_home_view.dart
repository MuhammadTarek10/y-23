import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/views/feedbacks/feedbacks_view.dart';
import 'package:y23/features/admin/presentation/views/quizzes/quizzes_view.dart';
import 'package:y23/features/admin/presentation/views/sessions/sessions_view.dart';
import 'package:y23/features/admin/presentation/views/tasks/tasks_view.dart';

class AdminHomeView extends ConsumerWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.admin.tr()),
            bottom: TabBar(
              tabs: [
                Tab(text: AppStrings.sessions.tr()),
                Tab(text: AppStrings.quizzes.tr()),
                Tab(text: AppStrings.tasks.tr()),
                Tab(text: AppStrings.feedbacks.tr()),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AdminSessionsView(),
              AdminQuizzesView(),
              AdminTasksView(),
              AdminFeedbacksView(),
            ],
          ),
        ),
      ),
    );
  }
}
