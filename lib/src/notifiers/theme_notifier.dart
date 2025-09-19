import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/theme_config.dart';
import '../services/theme_service.dart';
import '../providers/theme_config_provider.dart';

/// Theme notifier for managing theme state with Riverpod 3.x
class ThemeNotifier extends Notifier<ThemeMode> {
  late final ThemeService _themeService;
  late final ThemeConfig _config;

  @override
  ThemeMode build() {
    // Access config directly from provider
    _config = ref.watch(themeConfigProvider);
    _themeService = ThemeService(storageKey: _config.storageKey);
    
    // Load theme asynchronously
    _loadTheme();
    
    // Return initial state
    return _config.defaultThemeMode;
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

  /// Check if current theme is system
  bool get isSystem => state == ThemeMode.system;
}

