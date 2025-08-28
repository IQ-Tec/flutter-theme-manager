import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/theme_config.dart';
import '../services/theme_service.dart';

/// Theme notifier for managing theme state with Riverpod
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final ThemeService _themeService;
  final ThemeConfig _config;

  ThemeNotifier({
    required ThemeConfig config,
    ThemeService? themeService,
  }) : _config = config,
       _themeService = themeService ?? ThemeService(storageKey: config.storageKey),
       super(config.defaultThemeMode) {
    _loadTheme();
  }

  /// Load theme from storage
  Future<void> _loadTheme() async {
    final savedTheme = await _themeService.loadThemeMode();
    if (savedTheme != null) {
      state = savedTheme;
    }
  }

  /// Set theme mode and persist it
  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    await _themeService.saveThemeMode(themeMode);
  }

  /// Toggle between light and dark themes
  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setTheme(newTheme);
  }

  /// Reset to default theme
  Future<void> resetTheme() async {
    await setTheme(_config.defaultThemeMode);
  }

  /// Get current theme display name
  String get themeDisplayName {
    switch (state) {
      case ThemeMode.light:
        return _config.localization.lightThemeName;
      case ThemeMode.dark:
        return _config.localization.darkThemeName;
      case ThemeMode.system:
        return _config.localization.systemThemeName;
    }
  }

  /// Check if current theme is dark
  bool get isDark => state == ThemeMode.dark;

  /// Check if current theme is light
  bool get isLight => state == ThemeMode.light;

  /// Check if current theme follows system
  bool get isSystem => state == ThemeMode.system;

  /// Get theme configuration
  ThemeConfig get config => _config;
}
