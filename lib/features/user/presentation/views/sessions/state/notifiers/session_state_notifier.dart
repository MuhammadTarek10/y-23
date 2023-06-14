import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/domain/repositories/session_repository.dart';

class SessionsStateNotifier extends StateNotifier<List<Session>?> {
  final sessionRepo = instance<SessionRepository>();
  SessionsStateNotifier() : super(null) {
    getSessions();
  }

  Future<void> getSessions() async {
    final sessions = await sessionRepo.getSessions();
    if (sessions != null) sessions.sort((a, b) => a.title.compareTo(b.title));
    state = sessions;
  }

  Future<void> getSessionById(String id) async {
    final session = await sessionRepo.getSessionById(id);
    state = [session!];
  }

  Future<void> addOrUpdateSession(Session session) async {
    await sessionRepo.addOrUpdateSession(session);
    getSessions();
  }

  Future<void> sendFeedback(String id, String feedback) async {
    await sessionRepo.sendFeedback(id, feedback);
    getSessions();
  }

  Future<void> deleteSession(String id) async {
    await sessionRepo.deleteSession(id);
    getSessions();
  }

}
