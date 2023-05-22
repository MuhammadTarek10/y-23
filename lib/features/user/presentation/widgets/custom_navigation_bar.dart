import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/state/providers/bottom_navigation_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.option,
    required this.ref,
  });

  final BottomNavigationOptions option;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: option.index,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.sessions),
            icon: const Icon(Icons.task_outlined),
          ),
          label: AppStrings.sessions.tr(),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.quizzes),
            icon: const Icon(Icons.quiz_outlined),
          ),
          label: AppStrings.quizzes.tr(),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.profile),
            icon: const Icon(Icons.person_outline),
          ),
          label: AppStrings.profile.tr(),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.settings),
            icon: const Icon(Icons.settings),
          ),
          label: AppStrings.settings.tr(),
        ),
      ],
    );
  }
}
