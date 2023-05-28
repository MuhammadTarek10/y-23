import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';

class UploadTaskButton extends StatelessWidget {
  const UploadTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(AppSizes.s10),
        ),
        child: Text(AppStrings.uploadTask.tr()),
      ),
    );
  }
}
