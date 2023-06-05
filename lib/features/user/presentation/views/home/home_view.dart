import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/user/data/models/bottom_navigation_options.dart';
import 'package:y23/features/user/presentation/views/home/state/providers/bottom_navigation_provider.dart';
import 'package:y23/features/user/presentation/views/home/widgets/custom_navigation_bar.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final option = ref.watch(bottomNavigationProvider);
    final views = ref.read(bottomNavigationProvider.notifier).views;
    final pageController =
        ref.read(bottomNavigationProvider.notifier).pageController;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(bottomNavigationProvider.notifier)
                  .changeNavigation(BottomNavigationOptions.sessions);
            },
            icon: Image.asset(AppAssets.logo),
          ),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => views[index % views.length],
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollBehavior: const ScrollBehavior(),
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: CustomNavigationBar(option: option, ref: ref),
    );
  }
}
