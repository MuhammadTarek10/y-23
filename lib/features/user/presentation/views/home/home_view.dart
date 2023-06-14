import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/auth/state/providers/is_admin_provider.dart';
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
    final isAdmin = ref.watch(isAdminProvider);
    VoidCallback? callback;
    isAdmin.when(
      data: (data) {
        if (data == true) {
          callback = () => Navigator.pushNamed(
                context,
                Routes.adminHomeRoute,
              );
        }
      },
      error: (error, _) => null,
      loading: () => null,
    );
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                itemBuilder: (context, index) => views[index % views.length],
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                scrollBehavior: const ScrollBehavior(),
                scrollDirection: Axis.horizontal,
              ),
              Positioned(
                top: AppPadding.p0,
                left: AppPadding.p20,
                child: Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Positioned(
                top: AppPadding.p0,
                right: AppPadding.p20,
                child: IconButton(
                  onPressed: callback,
                  icon: Image.asset(
                    AppAssets.logo,
                    height: AppSizes.s50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(option: option, ref: ref),
    );
  }
}
