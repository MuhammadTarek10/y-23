import 'package:y23/features/admin/domain/entities/attendance.dart';

abstract class AttendanceRepo {
  Future<bool> addAttendance(Attendance attendance);
}
