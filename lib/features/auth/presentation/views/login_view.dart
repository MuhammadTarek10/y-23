import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(AppStrings.login.tr()),
          ),
          ElevatedButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
            child: Text(AppStrings.login.tr()),
          ),
          ElevatedButton(
            onPressed: ref.read(authStateProvider.notifier).logOut,
            child: Text(AppStrings.logout.tr()),
          ),
        ],
      ),
    );
  }
}
