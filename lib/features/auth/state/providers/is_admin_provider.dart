import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';

final isAdminProvider = StreamProvider.autoDispose<bool>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    final controller = StreamController<bool>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        final isAdmin = snapshot.docs.first.get(FirebaseFieldName.isAdmin);

        controller.sink.add(isAdmin);
      },
    );

    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);
