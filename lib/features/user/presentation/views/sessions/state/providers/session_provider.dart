import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';

final sessionProvider = StreamProvider.autoDispose<List<Session>?>(
  (ref) {
    final controller = StreamController<List<Session>?>();
    final subscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.sessions)
        .orderBy(FirebaseFieldName.sessionsTitle)
        .snapshots()
        .listen((snapshot) {
      final sessions = snapshot.docs
          .map(
            (e) => Session.fromJson(e.id, e.data()),
          )
          .toList();

      sessions.sort((a, b) => a.instructor.compareTo(b.instructor));
      controller.sink.add(sessions);
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
