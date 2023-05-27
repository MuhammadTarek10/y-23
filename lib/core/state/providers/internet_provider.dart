import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/state/notifiers/internet_state_notifier.dart';

final internetProvider = StateNotifierProvider<InternetStateNotifier, bool?>(
  (_) => InternetStateNotifier(),
);
