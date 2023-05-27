import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

class Sessioner {
  const Sessioner();

  Future<List<Session>?> getSessions() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.sessions)
        .get();

    return data.docs.map((e) => Session.fromJson(e.id, e.data())).toList();
  }

  Future<Session?> getSessionById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.sessions)
        .doc(id)
        .get();

    return Session.fromJson(data.id, data.data()!);
  }

  Future<bool> saveSession(Session session) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.sessions)
          .add(session.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> sendFeedback(String id, String feedback) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.sessions)
          .doc(id)
          .update({
        FirebaseFieldName.sessionsFeedback: FieldValue.arrayUnion([feedback])
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteSession(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.sessions)
          .doc(id)
          .delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateSession(Session session) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.sessions)
          .doc(session.id)
          .update(session.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }
}
