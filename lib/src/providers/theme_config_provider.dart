import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/theme_config.dart';

/// Global theme configuration provider
/// Override this in your ProviderScope if you need custom configuration
final themeConfigProvider = Provider<ThemeConfig>((ref) {
  return const ThemeConfig(); // Defaults razonables
});