import 'package:flutter/material.dart';
import 'package:y23/config/utils/values.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.type = TextInputType.multiline,
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
        child: TextField(
          controller: controller,
          keyboardType: type,
          cursorColor: Colors.blue,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            fillColor: Colors.white,
            labelText: hintText,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
