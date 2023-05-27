import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:y23/core/network_info.dart';
import 'package:y23/core/prefs.dart';

final instance = GetIt.instance;

Future<void> initApp() async {
  final shared = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => shared);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(prefs: instance()));
  instance.registerLazySingleton<NetworkInfoImp>(
      () => NetworkInfoImp(InternetConnectionChecker()));
}
