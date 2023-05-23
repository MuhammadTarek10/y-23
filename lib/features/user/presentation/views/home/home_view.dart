import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/user/presentation/views/home/widgets/custom_navigation_bar.dart';
import 'package:y23/features/user/presentation/views/home/state/providers/bottom_navigation_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final option = ref.watch(bottomNavigationProvider);
    final views = ref.read(bottomNavigationProvider.notifier).views;
    final pageController = ref.watch(bottomNavigationProvider.notifier).pageController;
    final displayName = ref.watch(userDisplayNameProvider) ?? "";
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
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(option: option, ref: ref),
    );
  }
}
