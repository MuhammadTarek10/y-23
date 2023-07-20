import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/di.dart';
import 'package:y23/features/admin/data/repositories/attendance_repository_impl.dart';
import 'package:y23/features/admin/domain/entities/attendance.dart';
import 'package:y23/features/admin/domain/repositories/attendance_repository.dart';

class AttendanceNotifier extends StateNotifier<bool> {
  final AttendanceRepo repo = instance<AttendanceRepoImpl>();
  AttendanceNotifier() : super(false);

  Future<bool> addAttendance(Attendance attendance) async {
    final result = await repo.addAttendance(attendance);
    state = result;
    return result;
  }
}
