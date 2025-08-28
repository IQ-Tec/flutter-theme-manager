import 'package:flutter/material.dart';

/// Configuration class for theme customization
class ThemeConfig {
  /// Light theme data
  final ThemeData? light;
  
  /// Dark theme data
  final ThemeData? dark;
  
  /// Key for storing theme preference in SharedPreferences
  final String storageKey;
  
  /// Default theme mode
  final ThemeMode defaultThemeMode;
  
  /// Localized text for theme selector
  final ThemeLocalization localization;

  const ThemeConfig({
    this.light,
    this.dark,
    this.storageKey = 'theme_mode',
    this.defaultThemeMode = ThemeMode.system,
    this.localization = const ThemeLocalization(),
  });

  /// Creates a copy of this config with the given fields replaced
  ThemeConfig copyWith({
    ThemeData? light,
    ThemeData? dark,
    String? storageKey,
    ThemeMode? defaultThemeMode,
    ThemeLocalization? localization,
  }) {
    return ThemeConfig(
      light: light ?? this.light,
      dark: dark ?? this.dark,
      storageKey: storageKey ?? this.storageKey,
      defaultThemeMode: defaultThemeMode ?? this.defaultThemeMode,
      localization: localization ?? this.localization,
    );
  }
}

/// Localization texts for the theme selector
class ThemeLocalization {
  /// Title for theme selector dialog
  final String dialogTitle;
  
  /// Cancel button text
  final String cancelButton;
  
  /// Theme selector tooltip
  final String selectorTooltip;
  
  /// Light theme name
  final String lightThemeName;
  
  /// Dark theme name
  final String darkThemeName;
  
  /// System theme name
  final String systemThemeName;
  
  /// Light theme description
  final String lightThemeDescription;
  
  /// Dark theme description
  final String darkThemeDescription;
  
  /// System theme description
  final String systemThemeDescription;
  
  /// Theme list tile title
  final String themeTitle;

  const ThemeLocalization({
    this.dialogTitle = 'Seleccionar Tema',
    this.cancelButton = 'Cancelar',
    this.selectorTooltip = 'Seleccionar Tema',
    this.lightThemeName = 'Claro',
    this.darkThemeName = 'Oscuro',
    this.systemThemeName = 'Sistema',
    this.lightThemeDescription = 'Siempre usar tema claro',
    this.darkThemeDescription = 'Siempre usar tema oscuro',
    this.systemThemeDescription = 'Seguir configuración del sistema',
    this.themeTitle = 'Tema',
  });

  /// Creates a copy of this localization with the given fields replaced
  ThemeLocalization copyWith({
    String? dialogTitle,
    String? cancelButton,
    String? selectorTooltip,
    String? lightThemeName,
    String? darkThemeName,
    String? systemThemeName,
    String? lightThemeDescription,
    String? darkThemeDescription,
    String? systemThemeDescription,
    String? themeTitle,
  }) {
    return ThemeLocalization(
      dialogTitle: dialogTitle ?? this.dialogTitle,
      cancelButton: cancelButton ?? this.cancelButton,
      selectorTooltip: selectorTooltip ?? this.selectorTooltip,
      lightThemeName: lightThemeName ?? this.lightThemeName,
      darkThemeName: darkThemeName ?? this.darkThemeName,
      systemThemeName: systemThemeName ?? this.systemThemeName,
      lightThemeDescription: lightThemeDescription ?? this.lightThemeDescription,
      darkThemeDescription: darkThemeDescription ?? this.darkThemeDescription,
      systemThemeDescription: systemThemeDescription ?? this.systemThemeDescription,
      themeTitle: themeTitle ?? this.themeTitle,
    );
  }
}
