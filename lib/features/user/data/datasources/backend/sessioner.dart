import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/data/datasources/session_datasource.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

class RemoteSessioner extends SessionDataSource {
  @override
  Future<List<Session>?> getSessions() async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.sessions)
        .get();

    return data.docs.map((e) => Session.fromJson(e.id, e.data())).toList();
  }

  @override
  Future<Session?> getSessionById(String id) async {
    final data = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.sessions)
        .doc(id)
        .get();

    return Session.fromJson(data.id, data.data()!);
  }

  @override
  Future<bool> addOrUpdateSession(Session session) async {
    if (session.id == null) {
      session = session.copyWith(id: const Uuid().v4());
    }
    try {
      final path = session.photoUrl;
      if (path == null || path.contains("firebase")) {
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.sessions)
            .doc(session.id)
            .set(session.toJson());
      } else {
        final name = session.photoUrl!.split("/").last;
        final path = "${FirebaseCollectionName.sessions}/${session.id}/$name";
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(File(session.photoUrl!));
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.sessions)
            .doc(session.id)
            .set(session.copyWith(photoUrl: downloadUrl).toJson());
      }
      return true;
    } catch (_) {
      log(_.toString());
      return false;
    }
  }

  @override
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

  @override
  Future<bool> deleteSession(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.sessions)
          .doc(id)
          .delete();
      await FirebaseStorage.instance
          .ref()
          .child(FirebaseCollectionName.sessions)
          .child(id)
          .delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}
