import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  final SharedPreferences _prefs;

  const AppPreference({required SharedPreferences prefs}) : _prefs = prefs;
}
