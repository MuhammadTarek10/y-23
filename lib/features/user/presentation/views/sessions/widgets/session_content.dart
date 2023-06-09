import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';

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
    return Expanded(
      child: SingleChildScrollView(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: opacity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p16,
                  vertical: AppPadding.p8,
                ),
                child: Text(
                  'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                  textAlign: TextAlign.justify,
                  maxLines: 200,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: AppSizes.s10),
              documentation != null
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
                          final url = Uri.parse(documentation!);
                          if (await canLaunchUrl(url)) {
                            launchUrl(url);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.details.tr(),
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
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ],
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
