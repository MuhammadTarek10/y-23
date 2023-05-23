import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/presentation/views/profile/profile_view.dart';
import 'package:y23/features/user/presentation/views/quizzes/quizzes_view.dart';
import 'package:y23/features/user/presentation/views/sessions/sessions_view.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view.dart';

class BottomNavigationStateNotifier
    extends StateNotifier<BottomNavigationOptions> {
  final PageController pageController;
  final views = const [
    SessionsView(),
    QuizzesView(),
    TasksView(),
    ProfileView(),
  ];
  BottomNavigationStateNotifier({required this.pageController})
      : super(BottomNavigationOptions.sessions);

  void changeNavigation(BottomNavigationOptions option) {
    state = option;
    pageController.animateToPage(
      option.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
