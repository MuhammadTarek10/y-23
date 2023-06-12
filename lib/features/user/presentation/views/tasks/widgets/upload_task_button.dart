import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';

class UploadTaskButton extends ConsumerWidget {
  const UploadTaskButton({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider) ?? "";
    return InkWell(
      onTap: () async {
        if (task.deadline.toDate().isBefore(DateTime.now())) {
          customShowSnackBar(
            context: context,
            message: AppStrings.taskDeadlinePassed.tr(),
            isError: true,
          );
          return;
        }

        final path = await FlutterDocumentPicker.openDocument();

        if (path == null) return;

        final file = File(path);
        ref.read(loadingProvider.notifier).loading();

        if (await ref.read(taskSubmissionsProvider.notifier).uploadSubmission(
              userId: userId,
              taskId: task.id,
              submission: file,
            )) {
          if (context.mounted) {
            customShowSnackBar(
              context: context,
              message: AppStrings.taskSubmittedSuccessfully.tr(),
            );
          }
        } else {
          if (context.mounted) {
            customShowSnackBar(
              context: context,
              message: AppStrings.errorSubmittingTask.tr(),
              isError: true,
            );
          }
        }

        ref.read(loadingProvider.notifier).doneLoading();
      },
      child: Container(
        width: context.width * 0.5,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppPadding.p12),
        margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(120),
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(AppSizes.s10),
        ),
        child: Text(
          AppStrings.uploadTask.tr(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.fakeWhite,
              ),
        ),
      ),
    );
  }
}
