import 'package:flutter/material.dart';
import 'package:y23/features/auth/domain/entities/user.dart';

class UserFeedbackViewParams {
  final User user;
  final VoidCallback onPressed;

  UserFeedbackViewParams({
    required this.user,
    required this.onPressed,
  });
}
