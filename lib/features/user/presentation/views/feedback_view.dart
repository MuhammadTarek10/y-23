import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/extensions.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/widgets/lottie.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/user/presentation/views/feedback/feedback_view_params.dart';

typedef FeedbackCallback = void Function(String feedback);

class FeedbackView extends StatefulWidget {
  const FeedbackView({
    super.key,
    required this.params,
  });

  final FeedbackViewParams params;

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  late final String title;
  late final FeedbackCallback onPressed;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    title = widget.params.title;
    onPressed = widget.params.onPressed;
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(title),
          elevation: 0,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: context.height,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: const LottieFeedback(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      AppStrings.addFeedback.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  _buildComposer(),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizes.s10),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.onSecondary,
                            ],
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (_controller.text.isNotEmpty) {
                                onPressed(_controller.text);
                              } else {
                                customShowSnackBar(
                                  context: context,
                                  message: AppStrings.fillFeedback.tr(),
                                  isError: true,
                                );
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  AppStrings.submit.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge,
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
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppPadding.p10),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            decoration: BoxDecoration(
                border: Border.all(
                  color: _controller.text.isNotEmpty
                      ? Theme.of(context).colorScheme.outline
                      : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(AppSizes.s10)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p0),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                onChanged: (String txt) {},
                cursorColor: Colors.blue,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
