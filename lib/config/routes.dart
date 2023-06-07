import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/state/providers/internet_provider.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/loading_screen.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/presentation/views/login_view.dart';
import 'package:y23/features/auth/state/providers/auth_loading_provider.dart';
import 'package:y23/features/auth/state/providers/is_logged_in_provider.dart';
import 'package:y23/features/splash/views/splash_view.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/feedback/feedback_view_params.dart';
import 'package:y23/features/user/presentation/views/feedback_view.dart';
import 'package:y23/features/user/presentation/views/help/help_view.dart';
import 'package:y23/features/user/presentation/views/home/home_view.dart';
import 'package:y23/features/user/presentation/views/leaderboard_view.dart';
import 'package:y23/features/user/presentation/views/quizzes/my_quizzes.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view_params.dart';
import 'package:y23/features/user/presentation/views/sessions/session_view.dart';
import 'package:y23/features/user/presentation/views/settings/settings_view.dart';
import 'package:y23/features/user/presentation/views/tasks/my_tasks/my_tasks.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';

class Routes {
  static const String initialRoute = "/";

  //* Auth
  static const String loginRoute = "/login";

  //* Admin

  //* User
  static const String homeRoute = "/home";
  static const String quizzesRoute = "/quizzes";
  static const String settingsRoute = "/settings";
  static const String helpRoute = "/help";
  static const String sessionRoute = "/session";
  static const String feedbackRoute = "/feedback";
  static const String leaderboardRoute = "/personal-feedback";
  static const String taskRoute = "/task";
  static const String myTasksRoute = "/my-tasks";
  static const String myQuizzesRoute = "/my-quizzes";

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
              final isInternet = ref.watch(internetProvider);
              ref.listen<bool>(
                authLoadingProvider,
                (_, isLoading) {
                  isLoggedIn
                      ? LoadingScreen.instance().show(context: context)
                      : LoadingScreen.instance().hide();
                },
              );
              return isLoggedIn
                  ? isInternet != null && isInternet
                      ? const HomeView()
                      : const LottieNoInternet()
                  : const LoginView();
            },
          ),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => Consumer(builder: (context, ref, child) {
            ref.listen<bool>(
              loadingProvider,
              (_, isLoading) {
                isLoading
                    ? LoadingScreen.instance().show(context: context)
                    : LoadingScreen.instance().hide();
              },
            );
            return const HomeView();
          }),
        );
      case Routes.quizzesRoute:
        return MaterialPageRoute(
          builder: (context) =>
              QuizView(params: settings.arguments as QuizViewParams),
        );
      case Routes.sessionRoute:
        return MaterialPageRoute(
          builder: (context) =>
              SessionView(session: settings.arguments as Session),
        );
      case Routes.feedbackRoute:
        return MaterialPageRoute(
          builder: (context) => FeedbackView(
            params: settings.arguments as FeedbackViewParams,
          ),
        );
      case Routes.leaderboardRoute:
        return MaterialPageRoute(
          builder: (context) => const LeaderboardView(),
        );

      case Routes.taskRoute:
        return MaterialPageRoute(
          builder: (context) => TaskView(
            params: settings.arguments as TaskViewParams,
          ),
        );
      case Routes.myTasksRoute:
        return MaterialPageRoute(
          builder: (context) => const MyTasksView(),
        );
      case Routes.myQuizzesRoute:
        return MaterialPageRoute(
          builder: (context) => const MyQuizzesView(),
        );
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (context) => const SettingsView());
      case Routes.helpRoute:
        return MaterialPageRoute(builder: (context) => const HelpView());
      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}
