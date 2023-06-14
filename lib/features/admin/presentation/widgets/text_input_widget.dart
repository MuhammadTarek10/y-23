import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/values.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.type = TextInputType.name,
    this.flex = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            border: Border.all(
              color: AppColors.fakeWhite,
            ),
            borderRadius: BorderRadius.circular(AppSizes.s10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            cursorColor: Colors.blue,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                  ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
