import 'package:flutter/material.dart';
import 'package:y23/features/auth/presentation/views/login_view.dart';

class Routes {
  static const String initialRoute = "/";

  //* Auth
  static const String loginRoute = "/login";

  //* Admin

  //* User

  //* Undefined
  static const String undefined = "/undefined";
}

class RouterGenerator {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const LoginView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}
