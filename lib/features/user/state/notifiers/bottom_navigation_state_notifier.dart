import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';

class BottomNavigationStateNotifier
    extends StateNotifier<BottomNavigationOptions> {
  final PageController pageController;
  BottomNavigationStateNotifier({required this.pageController})
      : super(BottomNavigationOptions.sessions);

  void changeNavigation(BottomNavigationOptions option) {
    state = option;
    pageController.jumpToPage(option.index);
  }
}
