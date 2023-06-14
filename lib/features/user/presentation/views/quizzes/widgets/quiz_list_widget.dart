import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz_result.dart';
import 'package:y23/features/user/presentation/views/quizzes/quiz_view_params.dart';

class QuizListWidget extends StatelessWidget {
  const QuizListWidget({
    super.key,
    required this.quiz,
    required this.result,
  });

  final Quiz quiz;
  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final height = context.height * 0.2;
    final width = context.width;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.quizzesRoute,
        arguments: QuizViewParams(
          quiz: quiz,
          result: result,
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
              height: height,
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
                    image: quiz.photoUrl != null
                        ? ResizeImage(
                            NetworkImage(quiz.photoUrl!),
                            width: width.toInt(),
                            height: height.toInt(),
                          )
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
                      quiz.title,
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
                              result.isTaken
                                  ? result.isPassed
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
                              "${result.score}/${quiz.questions.length}",
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
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
