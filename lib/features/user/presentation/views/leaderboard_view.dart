import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/providers/leaderboard_provider.dart';

class LeaderboardView extends ConsumerWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersScore = ref.watch(leaderboardProvider);
    return Container(
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
          title: Text(AppStrings.leaderboard.tr()),
          actions: [
            IconButton(
              onPressed: () async {
                ref.read(leaderboardProvider.notifier).getData();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: usersScore == null
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.outline,
              ))
            : SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            AppStrings.leader.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppSizes.s10),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: AppSizes.s100,
                                  backgroundImage:
                                      usersScore.keys.elementAt(0).photoUrl !=
                                                  null &&
                                              usersScore.keys
                                                  .elementAt(0)
                                                  .photoUrl!
                                                  .isNotEmpty
                                          ? NetworkImage(usersScore.keys
                                              .elementAt(0)
                                              .photoUrl!)
                                          : Image.asset(AppAssets.user).image,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: AppSizes.s100,
                                child: Container(
                                  height: AppSizes.s60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    border: Border.all(),
                                  ),
                                  child: const LottieCrown(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.s40),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: usersScore.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final user = usersScore.keys.elementAt(index);
                              final score = usersScore.values.elementAt(index);
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: AppPadding.p10),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: user.photoUrl !=
                                                    null &&
                                                user.photoUrl!.isNotEmpty
                                            ? NetworkImage(user.photoUrl!)
                                            : Image.asset(AppAssets.user).image,
                                      ),
                                      const SizedBox(width: AppSizes.s10),
                                      Expanded(child: Text(user.displayName!)),
                                    ],
                                  ),
                                  leading: Text(
                                    "# ${index + 1}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  trailing: Text(
                                    score.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
