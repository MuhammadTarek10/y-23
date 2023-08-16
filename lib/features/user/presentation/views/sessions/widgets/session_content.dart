import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';

class SessionContent extends StatelessWidget {
  const SessionContent({
    super.key,
    required this.documentation,
    required this.points,
    required this.opacity,
  });

  final String? documentation;
  final Map<String, dynamic>? points;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? sorted;
    if (points != null) {
      sorted = points.sort();
    }
    return Expanded(
      child: SingleChildScrollView(
        child: sorted!.isEmpty == true
            ? LottieEmpty(message: AppStrings.noContent.tr())
            : AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                        vertical: AppPadding.p8,
                      ),
                      child: points == null
                          ? LottieEmpty(message: AppStrings.noContent.tr())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: AppSizes.s10),
                                ...sorted.entries.map(
                                  (e) => Container(
                                    padding: const EdgeInsets.only(
                                      bottom: AppPadding.p20,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.key
                                              .split('.')[1]
                                              .trimLeft()
                                              .trimRight(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        const SizedBox(height: AppSizes.s10),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: AppPadding.p30,
                                          ),
                                          child: Text(
                                            e.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: AppSizes.s10),
                    documentation != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  final url = Uri.parse(documentation!);
                                  if (await canLaunchUrl(url)) {
                                    // ignore: deprecated_member_use
                                    launch(documentation!);
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.documentation.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    const SizedBox(width: AppSizes.s4),
                                    Icon(
                                      Icons.more_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}
