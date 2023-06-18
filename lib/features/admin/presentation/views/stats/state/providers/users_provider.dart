import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/domain/entities/user.dart';

final usersProvider = StreamProvider.autoDispose<List<User>>(
  (ref) {
    final controller = StreamController<List<User>>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .snapshots()
        .listen(
      (snapshot) {
        final users =
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
        users.sort(
          (a, b) => a.isAdmin == true && b.isAdmin == false ? 1 : -1,
        );
        controller.sink.add(users);
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
