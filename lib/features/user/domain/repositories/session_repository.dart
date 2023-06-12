import 'package:y23/features/user/data/datasources/backend/sessioner.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

class SessionRepository {
  final RemoteSessioner remoteSessioner;
  const SessionRepository({required this.remoteSessioner});

  Future<List<Session>?> getSessions() async {
    return await remoteSessioner.getSessions();
  }

  Future<Session?> getSessionById(String id) async {
    return await remoteSessioner.getSessionById(id);
  }

  Future<bool> addSession(Session session) async {
    return await remoteSessioner.addSession(session);
  }

  Future<bool> sendFeedback(String id, String feedback) async {
    return await remoteSessioner.sendFeedback(id, feedback);
  }

  Future<bool> deleteSession(String id) async {
    return await remoteSessioner.deleteSession(id);
  }

  Future<bool> updateSession(Session session) async {
    return await remoteSessioner.updateSession(session);
  }
}
