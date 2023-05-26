import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';

class HelpView extends ConsumerWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.help.tr()),
      ),
      body: Center(
        child: Text(AppStrings.help.tr()),
      ),
    );
  }
}
