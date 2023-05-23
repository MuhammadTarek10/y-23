import 'package:flutter/material.dart';

void customShowSnackBar({
  required BuildContext context,
  required String message,
  bool isError = false,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor ?? (isError ? Colors.red : Colors.green),
    ),
  );
}
