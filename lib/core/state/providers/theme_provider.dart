import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/core/state/notifiers/theme_state_notifier.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (_) => ThemeNotifier(),
);
