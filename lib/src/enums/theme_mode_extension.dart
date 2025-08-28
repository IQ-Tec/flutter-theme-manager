import 'package:flutter/material.dart';

/// Extension for ThemeMode to provide additional functionality
extension ThemeModeExtension on ThemeMode {
  /// Returns the display name for the theme mode in Spanish
  String get displayName {
    switch (this) {
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Oscuro';
      case ThemeMode.system:
        return 'Sistema';
    }
  }

  /// Returns the description for the theme mode in Spanish
  String get description {
    switch (this) {
      case ThemeMode.light:
        return 'Siempre usar tema claro';
      case ThemeMode.dark:
        return 'Siempre usar tema oscuro';
      case ThemeMode.system:
        return 'Seguir configuración del sistema';
    }
  }

  /// Returns the appropriate icon for the theme mode
  IconData get icon {
    switch (this) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.auto_awesome;
    }
  }

  /// Returns true if the theme mode is dark
  bool get isDark => this == ThemeMode.dark;

  /// Returns true if the theme mode is light
  bool get isLight => this == ThemeMode.light;

  /// Returns true if the theme mode follows system
  bool get isSystem => this == ThemeMode.system;
}
