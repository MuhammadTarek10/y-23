import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/auth/domain/entities/user.dart';

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
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    user.photoUrl != null && user.photoUrl!.isNotEmpty
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
        ),
      ],
    );
  }
}