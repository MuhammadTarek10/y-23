import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/domain/entities/tasks/task_submission.dart';
import 'package:y23/features/user/presentation/views/tasks/task_view_params.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.taskSubmission,
  });

  final Task task;
  final TaskSubmission taskSubmission;

  @override
  Widget build(BuildContext context) {
    final isSubmitted = taskSubmission.isSubmitted ?? false;
    final isCorrect = taskSubmission.isCorrect ?? false;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.taskRoute,
        arguments: TaskViewParams(
          task: task,
          taskSubmission: taskSubmission,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p10),
              margin: const EdgeInsets.only(
                top: AppPadding.p16,
                bottom: AppPadding.p10,
              ),
              height: context.height * 0.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).cardTheme.color!,
                      Theme.of(context).cardTheme.color!.withOpacity(0.5),
                    ],
                  ),
                  image: DecorationImage(
                    opacity: 0.4,
                    image: task.photoUrl != null
                        ? Image.network(task.photoUrl!).image
                        : Image.asset(AppAssets.logo).image,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.s20),
                    bottomLeft: Radius.circular(AppSizes.s20),
                    bottomRight: Radius.circular(AppSizes.s20),
                    topRight: Radius.circular(AppSizes.s20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: AppSizes.s20,
                        offset: const Offset(5, 15))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p4,
                      right: AppPadding.p12,
                      top: AppPadding.p10,
                    ),
                    child: Text(
                      task.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p4,
                      right: AppPadding.p4,
                      bottom: AppPadding.p10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isSubmitted
                                  ? isCorrect
                                      ? Icons.check
                                      : Icons.close
                                  : Icons.read_more,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(
                              width: context.width * 0.01,
                            ),
                            Text(
                              isSubmitted
                                  ? isCorrect
                                      ? AppStrings.correct.tr()
                                      : AppStrings.incorrect.tr()
                                  : AppStrings.notSubmitted.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
