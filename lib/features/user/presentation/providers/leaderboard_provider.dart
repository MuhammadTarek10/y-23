import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/auth/domain/entities/user.dart';
import 'package:y23/features/user/presentation/notifiers/leaderboard_notifier.dart';

final leaderboardProvider =
    StateNotifierProvider<LeaderboardNotifier, Map<User, int>?>(
  (_) => LeaderboardNotifier(),
);
