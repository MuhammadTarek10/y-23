import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/auth/state/providers/user_id_provider.dart';

final photoUrlProvider = StreamProvider.autoDispose<String?>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) return const Stream.empty();
    final controller = StreamController<String?>();
    final subscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .snapshots()
        .listen((event) {
      controller.sink.add(event.docs.first[FirebaseFieldName.photoUrl]);
    });

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
