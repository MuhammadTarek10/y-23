import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/domain/entities/user.dart';

final userProvider = StreamProvider.family.autoDispose<User, String>(
  (ref, userId) {
    final controller = StreamController<User>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .snapshots()
        .listen(
      (snapshot) {
        final user = snapshot.docs
            .map((doc) => User.fromJson(doc.data()))
            .firstWhere((element) => element.id == userId);
        controller.sink.add(user);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
