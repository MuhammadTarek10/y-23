import 'package:y23/features/user/domain/entities/sessions/session.dart';

abstract class SessionDataSource {
  Future<List<Session>?> getSessions();
  Future<Session?> getSessionById(String id);
  Future<bool> addSession(Session session);
  Future<bool> sendFeedback(String id, String feedback);
  Future<bool> deleteSession(String id);
  Future<bool> updateSession(Session session);
}
