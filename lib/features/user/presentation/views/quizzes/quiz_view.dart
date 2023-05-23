import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/presentation/views/quizzes/widgets/question_widget.dart';

class QuizView extends ConsumerWidget {
  const QuizView({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(quiz.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quiz.questions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  return QuestionWidget(question: question);
                },
              ),
              const SizedBox(height: AppSizes.s10),
              buildSubmitSection(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSubmitSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
          ),
          child: Text(AppStrings.areYouSure.tr()),
        ),
        Expanded(
          child: InkWell(
            onTap: () => log(quiz.toJson().toString()),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p10),
              margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(AppSizes.s10),
              ),
              child: Center(
                child: Text(
                  AppStrings.submit.tr(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
