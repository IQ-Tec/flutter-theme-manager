import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/theme_notifier.dart';
import 'theme_config_provider.dart';

/// Theme state provider using new Riverpod 3.x API
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

/// Helper providers for common theme checks
final isDarkThemeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider) == ThemeMode.dark;
});

final isLightThemeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider) == ThemeMode.light;
});

final isSystemThemeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider) == ThemeMode.system;
});

/// Theme display name provider
final themeDisplayNameProvider = Provider<String>((ref) {
  return ref.watch(themeProvider.notifier).themeDisplayName;
});

/// Current theme data providers
final currentLightThemeProvider = Provider<ThemeData>((ref) {
  final config = ref.watch(themeConfigProvider);
  return config.light ?? ThemeData.light();
});

final currentDarkThemeProvider = Provider<ThemeData>((ref) {
  final config = ref.watch(themeConfigProvider);
  return config.dark ?? ThemeData.dark();
});
