import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/features/admin/presentation/views/registration/state/notifiers/attendance_notifier.dart';

final attendanceFunctionalityProvider = StateNotifierProvider<AttendanceNotifier, bool>(
  (ref) => AttendanceNotifier(),
);
