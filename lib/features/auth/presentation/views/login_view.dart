import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/auth/presentation/widgets/login_button.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';
import 'package:y23/features/auth/state/providers/is_logged_in_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoggedIn = ref.watch(isLoggedInProvider);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.login.tr())),
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoggedIn
                ? LogOutButton(
                    onPressed: ref.read(authStateProvider.notifier).logOut,
                  )
                : GoogleLoginButton(
                    onPressed:
                        ref.read(authStateProvider.notifier).loginWithGoogle,
                  )
          ],
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LogOutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(AppStrings.logout.tr()),
          ),
        ),
      ),
    );
  }
}
