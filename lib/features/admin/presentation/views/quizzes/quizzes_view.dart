import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/widgets/admin_option_widget.dart';

class AdminQuizzesView extends ConsumerWidget {
  const AdminQuizzesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.5,
      ),
      children: [
        AdminOption(
          icon: Icons.add,
          title: AppStrings.addQuiz.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.addQuizRoute),
        ),
        AdminOption(
          icon: Icons.edit,
          title: AppStrings.editQuiz.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.editQuizRoute),
        ),
        AdminOption(
          icon: Icons.delete,
          title: AppStrings.deleteQuiz.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.deleteQuizRoute),
        ),
      ],
    );
  }
}
