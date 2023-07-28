import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/state/providers/is_logged_in_provider.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.65, 50),
      end: const Offset(0.65, 20),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        final isLoggedIn = ref.read(isLoggedInProvider);
        isLoggedIn ? _navigateToHome() : _navigateToLogin();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.onSecondary,
          ],
        ),
      ),
      child: Stack(
        children: [
          const Center(child: LottieSplash()),
          Positioned(
            left: 0,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionalTranslation(
                  translation: _animation.value,
                  child: child,
                );
              },
              child: Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.fakeWhite,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
