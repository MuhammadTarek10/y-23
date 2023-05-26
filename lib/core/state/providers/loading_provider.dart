import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/state/notifiers/loading_state_notifier.dart';

final loadingProvider = StateNotifierProvider<LoadingStateNotifier, bool>(
  (_) => LoadingStateNotifier(),
);
