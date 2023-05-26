import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/core/widgets/loading_screen.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/user/presentation/views/home/state/providers/bottom_navigation_provider.dart';
import 'package:y23/features/user/presentation/views/home/widgets/custom_navigation_bar.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  final prefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;
    final option = ref.watch(bottomNavigationProvider);
    final views = ref.read(bottomNavigationProvider.notifier).views;
    final pageController =
        ref.watch(bottomNavigationProvider.notifier).pageController;
    final displayName = ref.watch(userDisplayNameProvider) ?? "";
    ref.listen<bool>(
      loadingProvider,
      (_, isLoading) {
        isLoading
            ? LoadingScreen.instance().show(context: context)
            : LoadingScreen.instance().hide();
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => views[index % views.length],
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollBehavior: const ScrollBehavior(),
        scrollDirection: Axis.horizontal,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(),
              child: Text(
                "${AppStrings.welcome.tr()}\n${displayName.toUpperCase()}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppStrings.settings.tr()),
              onTap: () => Navigator.pushNamed(context, Routes.settingsRoute),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(AppStrings.help.tr()),
              onTap: () => Navigator.pushNamed(context, Routes.helpRoute),
            ),
            ListTile(
              leading: isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              title: Text(
                isDarkMode
                    ? AppStrings.lightMode.tr()
                    : AppStrings.darkMode.tr(),
              ),
              onTap: () {
                prefs.toggleTheme();
                ref.read(themeProvider.notifier).toggleTheme();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppStrings.language.tr()),
              onTap: () {
                prefs.toggleLanguage();
                Phoenix.rebirth(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(option: option, ref: ref),
    );
  }
}
