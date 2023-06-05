import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/presentation/views/feedback/feedback_view_params.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';

class TaskFeedbackButton extends ConsumerWidget {
  const TaskFeedbackButton({
    super.key,
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.feedbackRoute,
                  arguments: FeedbackViewParams(
                    onPressed: (feedback) => sendFeedback(
                      context,
                      ref,
                      feedback,
                      id,
                    ),
                    title: title,
                  ),
                );
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSizes.s16),
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Center(
                  child: Text(
                    AppStrings.addFeedback.tr(),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> sendFeedback(
    BuildContext context,
    WidgetRef ref,
    String feedback,
    String id,
  ) async {
    ref.read(loadingProvider.notifier).loading();
    await ref.read(taskSubmissionsProvider.notifier).sendFeedback(
          id: id,
          feedback: feedback,
        );
    ref.read(loadingProvider.notifier).doneLoading();
    if (context.mounted) {
      customShowSnackBar(
        context: context,
        message: AppStrings.feedbackAdded.tr(),
      );
      Navigator.pop(context);
    }
  }
}
