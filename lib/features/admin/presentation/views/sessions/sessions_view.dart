import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/widgets/admin_option_widget.dart';

class AdminSessionsView extends ConsumerWidget {
  const AdminSessionsView({super.key});

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
          title: AppStrings.addSession.tr(),
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.addSessionRoute,
          ),
        ),
        AdminOption(
          icon: Icons.edit,
          title: AppStrings.editSession.tr(),
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.editSessionRoute,
          ),
        ),
        AdminOption(
          icon: Icons.delete,
          title: AppStrings.deleteSession.tr(),
          onPressed: () =>
              Navigator.pushNamed(context, Routes.deleteSessionRoute),
        ),
      ],
    );
  }
}
