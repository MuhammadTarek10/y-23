import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_provider.dart';

class SessionView extends ConsumerWidget {
  const SessionView({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(session.title),
              ),
              const SizedBox(height: AppSizes.s20),
              buildFeedback(context, ref)
            ],
          ),
        ),
      ),
    );
  }

  Row buildFeedback(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.wantToAddFeedback.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: AppSizes.s10),
        Expanded(
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              Routes.feedbackRoute,
              arguments: {
                AppKeys.title: session.title,
                AppKeys.onPressed: (feedback) =>
                    sendFeedback(context, ref, feedback),
              },
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(AppSizes.s10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.addFeedback.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.add),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendFeedback(
    BuildContext context,
    WidgetRef ref,
    String feedback,
  ) async {
    ref.read(loadingProvider.notifier).loading();
    await ref.read(sessionsProvider.notifier).sendFeedback(
          session.id,
          feedback,
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