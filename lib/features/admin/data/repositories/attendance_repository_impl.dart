import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:y23/config/utils/firebase_names.dart';
import 'package:y23/features/admin/domain/entities/attendance.dart';
import 'package:y23/features/admin/domain/repositories/attendance_repository.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  @override
  Future<bool> addAttendance(Attendance attendance) async {
    if (attendance.attendance == null) return false;
    try {
      final data = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.attendance)
          .get();

      final result =
          data.docs.map((e) => Attendance.fromJson(e.id, e.data())).toList();

      for (var i = 0; i < result.length; i++) {
        final one = result[i];
        if (one.attendance!.keys.first == attendance.attendance!.keys.first) {
          final current = one.attendance!.values.first;
          final newEntries = attendance.attendance!.values.first;
          for (var i = 0; i < newEntries.length; i++) {
            final newEntry = newEntries[i];
            if (!current.contains(newEntry)) {
              current.add(newEntry);
            }
          }
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.attendance)
              .doc(one.id)
              .update({
            'attendance': {attendance.attendance!.keys.first: current}
          });
          return true;
        }
      }
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.attendance)
          .add(attendance.toJson());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
