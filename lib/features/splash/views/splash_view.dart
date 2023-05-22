import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/features/auth/state/providers/is_logged_in_provider.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final isLoggedIn = ref.read(isLoggedInProvider);
      isLoggedIn ? _navigateToHome() : _navigateToLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
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
