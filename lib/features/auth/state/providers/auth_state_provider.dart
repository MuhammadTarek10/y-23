import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/data/models/auth_state.dart';
import 'package:y23/features/auth/state/notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
