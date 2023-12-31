import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/assets.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/favorite_icon.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/feedback_button.dart';
import 'package:y23/features/user/presentation/views/sessions/widgets/session_content.dart';

class SessionView extends ConsumerStatefulWidget {
  const SessionView({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SessionViewState();
}

class _SessionViewState extends ConsumerState<SessionView>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = context.height - (context.width / 1.2) + 24.0;
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
        body: Stack(
          children: [
            Column(
              children: [
                Hero(
                  tag: widget.session.id!,
                  child: InteractiveViewer(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: widget.session.photoUrl != null &&
                              widget.session.photoUrl!.isNotEmpty
                          ? Image.network(
                              widget.session.photoUrl!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(AppAssets.logo),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (context.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: infoHeight,
                        maxHeight:
                            tempHeight > infoHeight ? tempHeight : infoHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppPadding.p32,
                              left: AppPadding.p18,
                              right: AppPadding.p16,
                            ),
                            child: Text(
                              widget.session.title,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ),
                          SessionContent(
                            documentation: widget.session.documentationLink,
                            points: widget.session.points,
                            opacity: opacity2,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).padding.bottom),
                          FeedbackButton(
                            id: widget.session.id!,
                            title: widget.session.title,
                            opacity: opacity3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FavoriteIcon(
                animationController: animationController,
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
