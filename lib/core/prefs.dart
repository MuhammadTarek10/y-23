import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:y23/config/language.dart';

class AppPreferences {
  final SharedPreferences prefs;
  const AppPreferences({required this.prefs});

  static const _isDarkModeKey = 'isDarkMode';
  static const prefKeyLang = 'prefKeyLang';

  Future<bool> isDarkMode() async {
    bool? isDarkMode = prefs.getBool(_isDarkModeKey);
    if (isDarkMode != null) {
      return isDarkMode;
    } else {
      return false;
    }
  }

  Future<void> toggleTheme() async {
    bool? isDarkMode = prefs.getBool(_isDarkModeKey);
    if (isDarkMode != null) {
      await prefs.setBool(_isDarkModeKey, !isDarkMode);
    } else {
      await prefs.setBool(_isDarkModeKey, false);
    }
  }

  Future<void> setLightMode() async {
    await prefs.setBool(_isDarkModeKey, false);
  }

  Future<String> getAppLanguage() async {
    String? language = prefs.getString(prefKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> toggleLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      prefs.setString(prefKeyLang, LanguageType.english.getValue());
    } else {
      prefs.setString(prefKeyLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    }
    return englishLocale;
  }
}
