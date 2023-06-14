import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/state/notifiers/session_state_notifier.dart';

final sessionFunctionalitiesProvider = StateNotifierProvider<SessionsStateNotifier, List<Session>?>(
  (ref) => SessionsStateNotifier(),
);
