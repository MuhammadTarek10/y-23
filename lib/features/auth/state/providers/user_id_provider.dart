import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';

final userIdProvider = Provider<String?>(
  (ref) => ref.watch(authStateProvider).userId,
);
