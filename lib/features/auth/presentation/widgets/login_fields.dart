import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(AppSizes.s20),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _displayNameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: AppStrings.displayName.tr(),
                    border: InputBorder.none,
                  ),
                ),
                Divider(color: Colors.black.withOpacity(0.4)),
                TextField(
                  controller: _emailController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: AppStrings.email.tr(),
                    border: InputBorder.none,
                  ),
                ),
                Divider(color: Colors.black.withOpacity(0.4)),
                TextField(
                  controller: _passwordController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: AppStrings.password.tr(),
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.s20),
          Consumer(builder: (context, ref, child) {
            return InkWell(
              onTap: () async {
                final displayName = _displayNameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                if (email.isEmpty || password.isEmpty) {
                  if (context.mounted) {
                    customShowSnackBar(
                      context: context,
                      message: AppStrings.fillEmailAndPassword.tr(),
                      isError: true,
                    );
                  }
                } else {
                  ref.read(loadingProvider.notifier).loading();
                  await ref
                      .read(authStateProvider.notifier)
                      .loginWithEmailAndPassword(email, password, displayName);
                  ref.read(loadingProvider.notifier).doneLoading();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.all(AppPadding.p10),
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(AppSizes.s20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    )),
                child: Text(
                  AppStrings.login.tr(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
