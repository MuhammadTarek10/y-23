import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';

final tasksProvider = StreamProvider.autoDispose<List<Task>?>(
  (ref) {
    final controller = StreamController<List<Task>?>();
    final subscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.tasks)
        .orderBy(FirebaseFieldName.tasksTitle)
        .snapshots()
        .listen(
      (snapshot) {
        final tasks = snapshot.docs
            .map(
              (e) => Task.fromJson(e.id, e.data()),
            )
            .toList();
        tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
        controller.sink.add(tasks);
      },
    );

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
