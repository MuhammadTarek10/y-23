import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/data/models/auth_result.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    return authState.result == AuthResults.success;
  },
);
