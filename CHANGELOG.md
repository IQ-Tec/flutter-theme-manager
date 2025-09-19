## 0.2.0 - 2025-08-28

### Changed
- **BREAKING CHANGE**: Migrado a Riverpod 3.x
- **BREAKING CHANGE**: `StateNotifierProvider` reemplazado por `NotifierProvider`
- **BREAKING CHANGE**: `StateNotifier` reemplazado por `Notifier`
- Actualizado `flutter_riverpod` de ^2.5.1 a ^3.0.0

### Added
- Nuevo archivo `theme_config_provider.dart` para evitar dependencias circulares
- Mejor separación de responsabilidades en providers

### Improved
- API más moderna usando las últimas características de Riverpod
- Mejor rendimiento con la nueva arquitectura de Riverpod 3.x

### Migration Guide
Para migrar de v0.1.x a v0.2.0:
1. Actualizar `flutter_riverpod` a ^3.0.0 en tu `pubspec.yaml`
2. No hay cambios necesarios en el código de usuario (solo en el pubspec.yaml)

## 0.1.0

### Added
- Initial release of Theme Manager package
- Theme management with light, dark, and system modes
- Automatic persistence using SharedPreferences
- Configurable theme settings via ThemeConfig
- Multiple widget options: ThemeSelector, ThemeDisplay, ThemeChip, ThemeBadge
- Full Riverpod integration with providers
- Localization support for UI texts
- Icon button and list tile theme selectors
- Programmatic theme control methods
- Extensions for ThemeMode with display names and icons
- Comprehensive example application
- Spanish localization by default

### Features
- 🎨 Simple light and dark theme management
- 💾 Automatic preference persistence
- 🔧 Fully configurable
- 🌍 Localization support
- 📱 Pre-built widgets for theme selection and display
- 🏗️ Riverpod compatible
- 🎯 Simple and consistent API
