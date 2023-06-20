import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/media.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';
import 'package:y23/features/auth/state/providers/is_admin_provider.dart';
import 'package:y23/features/auth/state/providers/photo_url_provider.dart';
import 'package:y23/features/auth/state/providers/user_display_name_provider.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({super.key});

  final AppPreferences prefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final displayName = ref.watch(userDisplayNameProvider);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;
    final photoUrl = ref.watch(photoUrlProvider);

    String? photo;
    photoUrl.when(
      data: (data) => photo = data,
      error: (error, _) {},
      loading: () {},
    );
    final adminStream = ref.watch(isAdminProvider);
    bool isAdmin = false;
    adminStream.when(
      data: (data) => isAdmin = data,
      error: (error, _) {},
      loading: () {},
    );
    return displayName == null || userId == null
        ? const LottieLoading()
        : ProfileDetails(
            ref: ref,
            userId: userId,
            displayName: displayName,
            photoUrl: photo,
            isDarkMode: isDarkMode,
            isAdmin: isAdmin,
            prefs: prefs,
          );
  }
}

class ProfileDetails extends StatelessWidget {
  ProfileDetails({
    super.key,
    required this.ref,
    required this.userId,
    required this.displayName,
    required this.photoUrl,
    required this.isDarkMode,
    required this.isAdmin,
    required this.prefs,
  });
  final imagePicker = instance<AppMedia>();
  final WidgetRef ref;
  final String userId;
  final String displayName;
  final String? photoUrl;
  final bool isDarkMode;
  final bool isAdmin;
  final AppPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p20),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: AppPadding.p40),
                      child: CircleAvatar(
                        radius: AppSizes.s80,
                        backgroundImage:
                            photoUrl != null && photoUrl!.isNotEmpty
                                ? NetworkImage(photoUrl!)
                                : Image.asset(AppAssets.user).image,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          final photo = await imagePicker.pickImage();
                          if (photo != null) {
                            ref
                                .read(authStateProvider.notifier)
                                .uploadProfilePicture(
                                  userId: userId,
                                  photo: File(photo.path),
                                );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(AppSizes.s20),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                displayName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: context.height * (isAdmin ? 0.12 : 0.2)),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(Icons.leaderboard_outlined),
                    title: Text(AppStrings.leaderboard.tr()),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.leaderboardRoute,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.task_outlined),
                    title: Text(AppStrings.performance.tr()),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.performanceRoute,
                    ),
                  ),
                  isAdmin
                      ? Column(
                          children: [
                            const Divider(),
                            ListTile(
                              leading:
                                  const Icon(Icons.pie_chart_outline_outlined),
                              title: Text(AppStrings.stats.tr()),
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.statsRoute,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: Text(AppStrings.help.tr()),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.helpRoute,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    title: Text(
                      !isDarkMode
                          ? AppStrings.lightMode.tr()
                          : AppStrings.darkMode.tr(),
                    ),
                    onTap: () {
                      prefs.toggleTheme();
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(AppStrings.language.tr()),
                    onTap: () {
                      prefs.toggleLanguage();
                      Phoenix.rebirth(context);
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.logout),
                  //   title: Text(AppStrings.logout.tr()),
                  //   onTap: ref.read(authStateProvider.notifier).logOut,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
