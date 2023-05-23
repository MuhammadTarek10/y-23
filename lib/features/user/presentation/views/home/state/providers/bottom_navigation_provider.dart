import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/presentation/views/home/state/notifiers/bottom_navigation_state_notifier.dart';

final bottomNavigationProvider = StateNotifierProvider<
    BottomNavigationStateNotifier, BottomNavigationOptions>(
  (_) => BottomNavigationStateNotifier(pageController: PageController()),
);
