import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/widgets/admin_option_widget.dart';

class AdminTasksView extends ConsumerWidget {
  const AdminTasksView({super.key});

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
          title: AppStrings.addTask.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.addTaskRoute),
        ),
        AdminOption(
          icon: Icons.edit,
          title: AppStrings.editTask.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.editTaskRoute),
        ),
        AdminOption(
          icon: Icons.delete,
          title: AppStrings.deleteTask.tr(),
          onPressed: () => Navigator.pushNamed(context, Routes.deleteTaskRoute),
        ),
      ],
    );
  }
}
