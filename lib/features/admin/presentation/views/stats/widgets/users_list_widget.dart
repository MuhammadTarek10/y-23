import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/auth/domain/entities/user.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';
import 'package:y23/features/user/presentation/views/feedback/feedback_view_params.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({
    super.key,
    required this.users,
    required this.admins,
  });

  final List<User> users;
  final List<User> admins;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UsersWidget(
          title: AppStrings.users.tr(),
          list: users,
        ),
        UsersWidget(
          title: AppStrings.admins.tr(),
          list: admins,
        ),
      ],
    );
  }
}

class UsersWidget extends StatelessWidget {
  const UsersWidget({
    super.key,
    required this.title,
    required this.list,
  });

  final String title;
  final List<User> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppPadding.p12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final user = list[index];
            return UserWidget(user: user);
          },
        ),
      ],
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ListTile(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.feedbackRoute,
            arguments: FeedbackViewParams(
              title: user.displayName!,
              onPressed: (feedback) => sendFeedback(
                context,
                ref,
                feedback,
                user.id,
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: user.photoUrl != null && user.photoUrl!.isNotEmpty
                ? Image.network(user.photoUrl!).image
                : Image.asset(AppAssets.user).image,
          ),
          title: Text(user.displayName!),
          subtitle: Text(user.email!),
          trailing: user.isAdmin
              ? const Icon(Icons.verified_user)
              : const Icon(Icons.people_alt_outlined),
        );
      },
    );
  }

  Future<void> sendFeedback(
    BuildContext context,
    WidgetRef ref,
    String feedback,
    String id,
  ) async {
    ref.read(loadingProvider.notifier).loading();
    await ref.read(authStateProvider.notifier).sendFeedback(id, feedback);
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
