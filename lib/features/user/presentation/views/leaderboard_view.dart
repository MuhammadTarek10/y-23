import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/user/presentation/providers/leaderboard_provider.dart';

class LeaderboardView extends ConsumerWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersScore = ref.watch(leaderboardProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.leaderboard.tr()),
        actions: [
          IconButton(
            onPressed: () => ref.read(leaderboardProvider.notifier).getData(),
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: usersScore == null
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.outline,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    AppStrings.rank1.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: AppSizes.s100,
                          backgroundImage:
                              usersScore.keys.elementAt(0).photoUrl != null
                                  ? NetworkImage(
                                      usersScore.keys.elementAt(0).photoUrl!)
                                  : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: AppSizes.s100,
                        child: Container(
                          height: AppSizes.s60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.outline,
                            border: Border.all(),
                          ),
                          child: const LottieCrown(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.s40),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: usersScore.length,
                    itemBuilder: (context, index) {
                      final user = usersScore.keys.elementAt(index);
                      final score = usersScore.values.elementAt(index);
                      return Container(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withAlpha(index * 5),
                        padding: const EdgeInsets.only(left: AppPadding.p10),
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: user.photoUrl != null
                                    ? NetworkImage(user.photoUrl!)
                                    : null,
                              ),
                              const SizedBox(width: AppSizes.s10),
                              Expanded(child: Text(user.displayName!)),
                            ],
                          ),
                          leading: Text(
                            "# ${index + 1}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          trailing: Text(
                            score.toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
