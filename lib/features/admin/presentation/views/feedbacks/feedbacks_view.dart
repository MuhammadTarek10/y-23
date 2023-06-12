import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_provider.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/tasks_provider.dart';

class AdminFeedbacksView extends ConsumerWidget {
  const AdminFeedbacksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, List<dynamic>>> feedbacks = [];
    final sessions = ref.watch(sessionProvider);
    final tasks = ref.watch(tasksProvider);
    sessions.when(
      data: (data) {
        if (data != null && data.isNotEmpty) {
          for (var session in data) {
            if (session.feedback != null && session.feedback!.isNotEmpty) {
              feedbacks.add({session.title: session.feedback!});
            }
          }
        }
      },
      error: (error, _) {},
      loading: () {},
    );
    tasks.when(
      data: (data) {
        if (data != null && data.isNotEmpty) {
          for (var task in data) {
            if (task.feedback != null && task.feedback!.isNotEmpty) {
              feedbacks.add({task.title: task.feedback!});
            }
          }
        }
      },
      error: (error, _) {},
      loading: () {},
    );
    return feedbacks.isEmpty
        ? LottieEmpty(message: AppStrings.noFeedback.tr())
        : ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index];
              return FeedbackWidget(
                title: feedback.keys.elementAt(0),
                content: feedback.values.toList(),
              );
            },
          );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final List<List<dynamic>> content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s10),
        border: Border.all(),
        color: Colors.grey.withOpacity(0.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.fakeWhite,
                ),
          ),
          const Divider(thickness: AppSizes.s4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: content.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final feedback = content[index];
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feedback.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final message = feedback[index];
                  return Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.fakeWhite.withOpacity(0.8),
                        ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
