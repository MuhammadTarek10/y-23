import 'package:flutter/material.dart';
import 'package:y23/config/utils/values.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppPadding.p0,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.green,
        ),
      ),
    );
  }
}
