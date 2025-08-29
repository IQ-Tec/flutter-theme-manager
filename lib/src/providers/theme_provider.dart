import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/theme_config.dart';
import '../notifiers/theme_notifier.dart';

/// Global theme configuration provider
/// Override this in your ProviderScope if you need custom configuration
final themeConfigProvider = Provider<ThemeConfig>((ref) {
  return const ThemeConfig(); // Defaults razonables
});

/// Theme state provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final config = ref.watch(themeConfigProvider);
  return ThemeNotifier(config: config);
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
