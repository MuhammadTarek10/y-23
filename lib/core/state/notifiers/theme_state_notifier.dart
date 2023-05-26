import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.darkModeTheme());

  void toggleTheme() {
    state = state.brightness == Brightness.dark
        ? AppTheme.lightModeTheme()
        : AppTheme.darkModeTheme();
  }

  void setTheme(bool isDark) {
    state = isDark ? AppTheme.darkModeTheme() : AppTheme.lightModeTheme();
  }
}
