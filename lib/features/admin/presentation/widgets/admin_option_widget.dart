import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/values.dart';

class AdminOption extends StatelessWidget {
  const AdminOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: AppSizes.s100,
        padding: const EdgeInsets.all(AppPadding.p10),
        margin: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppSizes.s10),
            bottomLeft: Radius.circular(AppSizes.s20),
          ),
          gradient: const LinearGradient(
            colors: [
              AppColors.fifthlyColor,
              AppColors.secondlyColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSizes.s60,
            ),
            const SizedBox(height: AppSizes.s10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.fakeWhite,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
