import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addFeedback.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.s10),
            TextField(
              focusNode: FocusNode()..requestFocus(),
              controller: _controller,
              decoration: InputDecoration(
                hintText: AppStrings.addFeedback.tr(),
                border: const OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: AppSizes.s20),
            InkWell(
              onTap: () {
                if (_controller.text.isNotEmpty) {
                  onPressed(_controller.text);
                } else {
                  return;
                }
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _controller.text.isNotEmpty
                        ? AppColors.primaryColor
                        : Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.s10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    AppStrings.submit.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
