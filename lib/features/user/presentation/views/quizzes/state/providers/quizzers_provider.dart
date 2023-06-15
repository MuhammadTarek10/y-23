import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';

final quizzesProvider = StreamProvider.autoDispose<List<Quiz>?>(
  (ref) {
    final controller = StreamController<List<Quiz>?>();
    final subscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.quizzes)
        .orderBy(FirebaseFieldName.quizTitle)
        .snapshots()
        .listen(
      (snapshot) {
        final quizzes = snapshot.docs
            .map(
              (e) => Quiz.fromJson(e.id, e.data()),
            )
            .toList();
        controller.sink.add(quizzes);
      },
    );

    ref.onDispose(() {
      subscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
