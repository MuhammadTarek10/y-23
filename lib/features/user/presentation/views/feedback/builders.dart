import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/presentation/views/sessions/session_view_params.dart';

typedef OnPressed = void Function(
  BuildContext context,
  WidgetRef ref,
  String feedback,
);

Row buildFeedback({
  required BuildContext context,
  required WidgetRef ref,
  required String title,
  required OnPressed onPressed,
}) {
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
            arguments: FeedbackViewParams(
              title: title,
              onPressed: (feedback) => onPressed(context, ref, feedback),
            ),
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
