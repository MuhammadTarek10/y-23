import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/user/data/datasources/backend/sessioner.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

class SessionsStateNotifier extends StateNotifier<List<Session>?> {
  final sessioner = const Sessioner();
  SessionsStateNotifier() : super(null) {
    getSessions();
  }

  Future<void> getSessions() async {
    state = await sessioner.getSessions();
  }

  Future<void> getSessionById(String id) async {
    final session = await sessioner.getSessionById(id);
    state = [session!];
  }

  Future<void> saveSession(Session session) async {
    await sessioner.saveSession(session);
    getSessions();
  }

  Future<void> sendFeedback(String id, String feedback) async {
    await sessioner.sendFeedback(id, feedback);
    getSessions();
  }

  Future<void> deleteSession(String id) async {
    await sessioner.deleteSession(id);
    getSessions();
  }

  Future<void> updateSession(Session session) async {
    await sessioner.updateSession(session);
    getSessions();
  }
}
