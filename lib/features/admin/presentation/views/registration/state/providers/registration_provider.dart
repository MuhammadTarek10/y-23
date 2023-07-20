import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/admin/domain/entities/attendance.dart';

final attendanceProvider = StreamProvider.autoDispose<List<Attendance>>((ref) {
  final controller = StreamController<List<Attendance>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.attendance)
      .snapshots()
      .listen((snapshot) {
    final attendance = snapshot.docs.map((doc) {
      return Attendance.fromJson(doc.id, doc.data());
    }).toList();

    // sort list by length of attendance values
    attendance.sort((a, b) => b.attendance![b.attendance!.keys.first].length
        .compareTo(a.attendance![a.attendance!.keys.first].length));

    controller.add(attendance);
  });
  ref.onDispose(
    () {
      sub.cancel();
      controller.close();
    },
  );

  return controller.stream;
});
