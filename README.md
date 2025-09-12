# Theme Manager

Un paquete Flutter configurable y reutilizable para gestión de temas con soporte para Riverpod y persistencia automática.

## ✨ Características

- 🎨 Gestión sencilla de temas claro y oscuro
- 💾 Persistencia automática con SharedPreferences
- 🔧 Completamente configurable (desde plug & play hasta personalización total)
- 🌍 Soporte para localización (español por defecto)
- 📱 Widgets predefinidos listos para usar
- 🏗️ Compatible con Riverpod (convive con Provider clásico)
- 🎯 API simple y consistente

## 📦 Instalación

```yaml
dependencies:
  theme_manager:
    git:
      url: https://github.com/IQ-Tec/flutter-theme-manager.git
      ref: v0.1.0
  flutter_riverpod: ^2.5.1  # Necesario para ConsumerWidget
```

## 🚀 Uso Básico (Plug & Play)

### 1. Configuración mínima

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_manager/theme_manager.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// Solo MaterialApp necesita ser ConsumerWidget
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: ThemeData.light(),     // Tu tema claro
      darkTheme: ThemeData.dark(),  // Tu tema oscuro
      themeMode: themeMode,         // Manejado por theme_manager
      home: HomeScreen(),
    );
  }
}
```

### 2. Agregar widgets

```dart
// En AppBar como icono
AppBar(
  title: Text('Mi App'),
  actions: [
    ThemeSelector.iconButton(),
  ],
)

// En configuraciones como ListTile
Column(
  children: [
    ThemeSelector.listTile(),
    // Otras configuraciones...
  ],
)

// Para mostrar el tema actual
Row(
  children: [
    Text('Tema: '),
    ThemeDisplay(),
  ],
)
```

## 🎨 Configuración Intermedia

### Personalizar temas

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: _buildLightTheme(),    // Tu tema personalizado
      darkTheme: _buildDarkTheme(), // Tu tema personalizado
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
  
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // Tu personalización...
    );
  }
  
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      // Tu personalización...
    );
  }
}
```

### Widgets personalizados

```dart
// Selector con icono personalizado
ThemeSelector.iconButton(
  customIcon: Icons.palette,
)

// Con callback personalizado
ThemeSelector.listTile(
  onThemeChanged: (ThemeMode mode) {
    print('Tema cambiado a: $mode');
    // Tu lógica personalizada
  },
```

## 🎯 Dos Formas de Usar el Paquete

### Forma 1: Solo Gestión de Estado (Recomendado para empezar)
```dart
// El paquete SOLO maneja el ThemeMode (light/dark/system)
// TÚ defines los temas en tu app
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: AppTheme.lightTheme,    // TU tema personalizado
      darkTheme: AppTheme.darkTheme, // TU tema personalizado
      themeMode: themeMode,          // Solo el modo del paquete
      home: HomeScreen(),
    );
  }
}
```

### Forma 2: Gestión Completa (Avanzado)
```dart
// El paquete gestiona TANTO el modo COMO los temas
// TÚ le das tus temas al paquete, él los devuelve cuando los necesites

// 1. Configurar el paquete con TUS temas
ProviderScope(
  overrides: [
    themeConfigProvider.overrideWithValue(
      ThemeConfig(
        light: AppTheme.lightTheme,  // TU tema → al paquete
        dark: AppTheme.darkTheme,    // TU tema → al paquete
      ),
    ),
  ],
  child: MyApp(),
)

// 2. El paquete devuelve TUS temas cuando los pidas
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final lightTheme = ref.watch(currentLightThemeProvider);  // TU tema desde el paquete
    final darkTheme = ref.watch(currentDarkThemeProvider);    // TU tema desde el paquete
    
    return MaterialApp(
      theme: lightTheme,      // El paquete devuelve TU tema
      darkTheme: darkTheme,   // El paquete devuelve TU tema
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
}
```

### 🔍 Sistema de Fallbacks

El paquete funciona como un **contenedor inteligente**:

```dart
// Si NO le das temas personalizados:
currentLightThemeProvider → ThemeData.light()   // Fallback de Flutter
currentDarkThemeProvider → ThemeData.dark()     // Fallback de Flutter

// Si SÍ le das tus temas:
currentLightThemeProvider → AppTheme.lightTheme  // TU tema
currentDarkThemeProvider → AppTheme.darkTheme    // TU tema
```

**El paquete NUNCA define estilos propios, solo gestiona lo que TÚ le das.**

## ⚙️ Configuración Avanzada

### 1. Override completo de configuración

```dart
void main() {
  runApp(
    ProviderScope(
      overrides: [
        themeConfigProvider.overrideWithValue(
          ThemeConfig(
            light: MyCustomThemes.light,
            dark: MyCustomThemes.dark,
            defaultThemeMode: ThemeMode.dark,
            storageKey: 'mi_app_theme_personalizada',
            localization: ThemeLocalization(
              dialogTitle: 'Elegir Tema',
              lightThemeName: 'Claro',
              darkThemeName: 'Oscuro',
              systemThemeName: 'Auto',
              // Personaliza todos los textos...
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
```

### 2. Localización personalizada

```dart
// Para inglés
ThemeConfig(
  localization: ThemeLocalization(
    dialogTitle: 'Select Theme',
    lightThemeName: 'Light',
    darkThemeName: 'Dark',
    systemThemeName: 'System',
    lightThemeDescription: 'Always use light theme',
    darkThemeDescription: 'Always use dark theme',
    systemThemeDescription: 'Follow system settings',
    themeTitle: 'Theme',
    selectorTooltip: 'Select Theme',
    cancelButton: 'Cancel',
  ),
)

// Para francés
ThemeConfig(
  localization: ThemeLocalization(
    dialogTitle: 'Sélectionner le Thème',
    lightThemeName: 'Clair',
    darkThemeName: 'Sombre',
    systemThemeName: 'Système',
    // etc...
  ),
)
```

### 3. Configuración por widget

```dart
// Override de configuración solo para este widget
ThemeSelector.listTile(
  customConfig: ThemeConfig(
    localization: ThemeLocalization(
      dialogTitle: 'Mi Título Personalizado',
      // Solo este widget usará estos textos
    ),
  ),
)
```

## 🔧 API Completa

### Widgets Disponibles

```dart
// Constructores principales
ThemeSelector.iconButton({
  IconData? customIcon,
  ThemeConfig? customConfig,
  Function(ThemeMode)? onThemeChanged,
})

ThemeSelector.listTile({
  ThemeConfig? customConfig,
  Function(ThemeMode)? onThemeChanged,
})

// Widget de display
ThemeDisplay()
```

### Providers Disponibles

```dart
// Principal
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>

// Helpers
final isDarkThemeProvider = Provider<bool>
final isLightThemeProvider = Provider<bool>
final isSystemThemeProvider = Provider<bool>
final themeDisplayNameProvider = Provider<String>
final currentLightThemeProvider = Provider<ThemeData>
final currentDarkThemeProvider = Provider<ThemeData>
```

### Métodos del Notifier

```dart
// Cambiar tema
ref.read(themeProvider.notifier).setTheme(ThemeMode.dark);

// Obtener información
final notifier = ref.read(themeProvider.notifier);
String displayName = notifier.themeDisplayName;
bool isDark = notifier.isDarkMode;
bool isSystem = notifier.isSystemMode;
```

## 🤝 Convivencia con Provider

El paquete convive perfectamente con apps que usan Provider clásico:

```dart
// Tu app existente
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    // ... otros providers
  ],
  child: ProviderScope( // Solo para theme_manager
    child: MyApp(),
  ),
)

// En cualquier pantalla
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tu UI existente con Provider
        Consumer<UserProvider>(
          builder: (context, user, _) => UserProfile(user: user),
        ),
        
        // Selector de tema (usa Riverpod internamente)
        ThemeSelector.listTile(),
      ],
    );
  }
}
```

## 📚 Ejemplos Completos

Consulta la carpeta `example/` para ver:
- ✅ Configuración básica
- ✅ Personalización de temas
- ✅ Localización múltiple
- ✅ Convivencia con Provider

## 🛠️ Mejores Prácticas

Para patrones de uso avanzados y mejores prácticas, consulta [BEST_PRACTICES.md](BEST_PRACTICES.md).

## 📋 Changelog

Consulta [CHANGELOG.md](CHANGELOG.md) para ver las novedades y cambios en cada versión.

## 📄 Licencia

MIT
