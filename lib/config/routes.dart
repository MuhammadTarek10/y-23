import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/presentation/views/login_view.dart';
import 'package:y23/features/auth/state/providers/is_logged_in_provider.dart';
import 'package:y23/features/splash/views/splash_view.dart';
import 'package:y23/features/user/presentation/views/home_view.dart';

class Routes {
  static const String initialRoute = "/";

  //* Auth
  static const String loginRoute = "/login";

  //* Admin

  //* User
  static const String homeRoute = "/home";

  //* Undefined
  static const String undefined = "/undefined";
}

class RouterGenerator {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref.watch(isLoggedInProvider);
              return isLoggedIn ? const HomeView() : const LoginView();
            },
          ),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}
