import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing theme persistence
class ThemeService {
  final String _storageKey;
  SharedPreferences? _prefs;

  ThemeService({String storageKey = 'theme_mode'}) : _storageKey = storageKey;

  /// Initialize the service
  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Load theme mode from storage
  Future<ThemeMode?> loadThemeMode() async {
    await initialize();
    final themeIndex = _prefs?.getInt(_storageKey);
    
    if (themeIndex != null && themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      return ThemeMode.values[themeIndex];
    }
    
    return null;
  }

  /// Save theme mode to storage
  Future<bool> saveThemeMode(ThemeMode themeMode) async {
    await initialize();
    return await _prefs?.setInt(_storageKey, themeMode.index) ?? false;
  }

  /// Clear theme mode from storage
  Future<bool> clearThemeMode() async {
    await initialize();
    return await _prefs?.remove(_storageKey) ?? false;
  }
}
