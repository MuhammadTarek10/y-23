import 'package:flutter/foundation.dart' show immutable;
import 'package:y23/features/user/presentation/views/feedback_view.dart';

@immutable
class FeedbackViewParams {
  const FeedbackViewParams({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final FeedbackCallback onPressed;

  FeedbackViewParams copyWith({
    String? title,
    FeedbackCallback? onPressed,
  }) {
    return FeedbackViewParams(
      title: title ?? this.title,
      onPressed: onPressed ?? this.onPressed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackViewParams &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          onPressed == other.onPressed;

  @override
  int get hashCode => title.hashCode ^ onPressed.hashCode;

  @override
  String toString() =>
      'SessionViewParams{title: $title, onPressed: $onPressed}';
}
