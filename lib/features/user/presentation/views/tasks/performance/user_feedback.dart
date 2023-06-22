import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/domain/entities/user.dart';

class UserFeedback extends StatelessWidget {
  const UserFeedback({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return user.feedback == null || user.feedback!.isEmpty
        ? LottieEmpty(message: AppStrings.noFeedback.tr())
        : Column(
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
                itemCount: user.feedback!.length,
                itemBuilder: (context, index) {
                  final feedback = user.feedback![index];
                  return FeedbackWidget(feedback: feedback);
                },
              ),
            ],
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
