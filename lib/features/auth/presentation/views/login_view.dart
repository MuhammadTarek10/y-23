import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/presentation/widgets/google_login_button.dart';
import 'package:y23/features/auth/presentation/widgets/login_fields.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: double.infinity,
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
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  AppStrings.welcome.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const LottieLogin(),
                const LoginFields(),
                const GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               AppStrings.welcome.tr(),
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//             const LottieLogin(),
//             const LoginFields(),
//             const Spacer(),
//             const GoogleLoginButton(),
//           ],
//         ),