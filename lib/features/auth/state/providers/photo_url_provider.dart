import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/state/providers/auth_state_provider.dart';

final photoUrlProvider = Provider<String?>(
  (ref) => ref.watch(authStateProvider).photoUrl,
);
