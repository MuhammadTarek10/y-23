import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:y23/core/media.dart';
import 'package:y23/core/network_info.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/features/admin/data/repositories/attendance_repository_impl.dart';
import 'package:y23/features/user/data/datasources/backend/quizzer.dart';
import 'package:y23/features/user/data/datasources/backend/sessioner.dart';
import 'package:y23/features/user/data/datasources/backend/tasker.dart';
import 'package:y23/features/user/domain/repositories/quiz_repository.dart';
import 'package:y23/features/user/domain/repositories/session_repository.dart';
import 'package:y23/features/user/domain/repositories/task_repository.dart';

final instance = GetIt.instance;

Future<void> initApp() async {
  final shared = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => shared);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(prefs: instance()));
  instance.registerLazySingleton<NetworkInfoImp>(
      () => NetworkInfoImp(InternetConnectionChecker()));
  instance.registerLazySingleton<AppMedia>(
      () => AppMedia(imagePicker: ImagePicker()));

  instance.registerLazySingleton<RemoteTasker>(() => RemoteTasker());
  instance.registerLazySingleton<TaskRepository>(
    () => TaskRepository(
      remoteTasker: instance<RemoteTasker>(),
    ),
  );

  instance.registerLazySingleton<RemoteSessioner>(() => RemoteSessioner());
  instance.registerLazySingleton<SessionRepository>(
    () => SessionRepository(
      remoteSessioner: instance<RemoteSessioner>(),
    ),
  );

  instance.registerLazySingleton<RemoteQuizzer>(() => RemoteQuizzer());
  instance.registerLazySingleton<QuizRepository>(
    () => QuizRepository(
      remoteQuizzer: instance<RemoteQuizzer>(),
    ),
  );
  instance.registerLazySingleton<AttendanceRepoImpl>(
    () => AttendanceRepoImpl(),
  );
}
