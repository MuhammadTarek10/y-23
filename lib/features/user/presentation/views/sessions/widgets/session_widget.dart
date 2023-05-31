import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.sessionRoute,
        arguments: session,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
            child: Container(
              padding: const EdgeInsets.all(AppPadding.p10),
              margin: const EdgeInsets.only(
                top: AppPadding.p16,
                bottom: AppPadding.p10,
              ),
              height: context.height * 0.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  image: DecorationImage(
                    opacity: 0.4,
                    image: session.photoUrl != null
                        ? Image.network(session.photoUrl!).image
                        : Image.asset(AppAssets.logo).image,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.s20),
                    bottomLeft: Radius.circular(AppSizes.s20),
                    bottomRight: Radius.circular(AppSizes.s20),
                    topRight: Radius.circular(AppSizes.s20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: AppSizes.s20,
                        offset: const Offset(5, 15))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p4,
                      right: AppPadding.p12,
                      top: AppPadding.p10,
                    ),
                    child: Text(
                      session.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p4,
                      right: AppPadding.p4,
                      bottom: AppPadding.p10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                            SizedBox(
                              width: context.width * 0.01,
                            ),
                            Text(
                              session.instructor,
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
