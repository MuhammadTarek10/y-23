import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/utils/constants.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';

class HelpView extends ConsumerWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          title: Text(AppStrings.help.tr()),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: const LottieHelp(),
              ),
              const SizedBox(height: AppSizes.s40),
              Text(
                AppStrings.helpYou.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  AppStrings.helpDesc.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSizes.s40,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.s10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(Constants.contactUs);
                          if (await canLaunchUrl(url)) {
                            launch(Constants.contactUs);
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p4),
                            child: Text(
                              AppStrings.chatWithUs.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
