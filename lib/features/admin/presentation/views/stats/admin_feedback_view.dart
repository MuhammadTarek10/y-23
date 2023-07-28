import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/admin/presentation/views/stats/widgets/user_feedback_view_params.dart';

class AdminUserFeedback extends StatelessWidget {
  const AdminUserFeedback({
    super.key,
    required this.params,
  });

  final UserFeedbackViewParams params;

  @override
  Widget build(BuildContext context) {
    return params.user.feedback == null || params.user.feedback!.isEmpty
        ? Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(params.user.displayName.toString()),
              ),
              body: LottieEmpty(
                message: AppStrings.noFeedback.tr(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: params.onPressed,
                child: const Icon(Icons.add),
              ),
            ),
          )
        : Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(params.user.displayName.toString()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: params.onPressed,
                child: const Icon(Icons.add),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Text(
                      AppStrings.feedbacks.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: params.user.feedback!.length,
                    itemBuilder: (context, index) {
                      final feedback = params.user.feedback![index];
                      return FeedbackWidget(feedback: feedback);
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.feedback,
  });

  final String feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s10),
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedback,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
