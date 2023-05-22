import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(AppSizes.s10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: AppSizes.s10,
                ),
                Text(
                  AppStrings.googleLogin.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Image.asset(
                  AppAssets.googleLogo,
                  width: AppSizes.s30,
                  height: AppSizes.s30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
