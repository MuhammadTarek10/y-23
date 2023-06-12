import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/presentation/views/home/state/providers/bottom_navigation_provider.dart';

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
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    const color = AppColors.primaryColor;
    final backgroundColor =
        isDarkMode ? Colors.transparent : AppColors.secondlyColor;
    return BubbleBottomBar(
      opacity: 0.2,
      backgroundColor: backgroundColor,
      currentIndex: option.index,
      items: [
        BubbleBottomBarItem(
          backgroundColor: color,
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.sessions),
            icon: const Icon(Icons.task_outlined),
          ),
          activeIcon: const Icon(Icons.task),
          title: Text(
            AppStrings.sessions.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: color,
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.quizzes),
            icon: const Icon(Icons.quiz_outlined),
          ),
          activeIcon: const Icon(Icons.quiz),
          title: Text(
            AppStrings.quizzes.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: color,
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.tasks),
            icon: const Icon(Icons.flag_outlined),
          ),
          activeIcon: const Icon(Icons.flag),
          title: Text(
            AppStrings.tasks.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
        BubbleBottomBarItem(
          backgroundColor: color,
          icon: IconButton(
            onPressed: () => ref
                .read(bottomNavigationProvider.notifier)
                .changeNavigation(BottomNavigationOptions.profile),
            icon: const Icon(Icons.person_outline),
          ),
          activeIcon: const Icon(Icons.person),
          title: Text(
            AppStrings.profile.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ],
    );
  }
}
