# Theme Manager

Un paquete Flutter configurable y reutilizable para gestión de temas con soporte para Riverpod y persistencia automática.

## Características

- 🎨 Gestión sencilla de temas claro y oscuro
- 💾 Persistencia automática de preferencias usando SharedPreferences
- 🔧 Completamente configurable
- 🌍 Soporte para localización
- 📱 Widgets predefinidos para selector y display de tema
- 🏗️ Compatible con Riverpod
- 🎯 API simple y consistente

## Instalación

Añade esto a tu `pubspec.yaml`:

```yaml
dependencies:
  theme_manager: ^0.1.0
  flutter_riverpod: ^2.5.1
```

## Uso Básico

### 1. Configuración inicial

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_manager/theme_manager.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        // Configura el tema
        themeConfigProvider.overrideWithValue(
          ThemeConfig(
            light: ThemeData.light(),
            dark: ThemeData.dark(),
            defaultThemeMode: ThemeMode.system,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final lightTheme = ref.watch(currentLightThemeProvider);
    final darkTheme = ref.watch(currentDarkThemeProvider);

    return MaterialApp(
      title: 'Mi App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: MyHomePage(),
    );
  }
}
```

### 2. Usando los widgets

#### Selector de tema como botón de icono

```dart
AppBar(
  title: Text('Mi App'),
  actions: [
    ThemeSelector.iconButton(),
  ],
)
```

#### Selector de tema como ListTile

```dart
Column(
  children: [
    ThemeSelector.listTile(),
    // otros widgets...
  ],
)
```

#### Display del tema actual

```dart
// Display simple
ThemeDisplay()

// Como chip
ThemeChip(
  onTap: () {
    // Acción personalizada
  },
)

// Como badge
ThemeBadge()
```

### 3. Controlando el tema programáticamente

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => themeNotifier.setTheme(ThemeMode.dark),
          child: Text('Tema Oscuro'),
        ),
        ElevatedButton(
          onPressed: () => themeNotifier.setTheme(ThemeMode.light),
          child: Text('Tema Claro'),
        ),
        ElevatedButton(
          onPressed: () => themeNotifier.toggleTheme(),
          child: Text('Alternar Tema'),
        ),
      ],
    );
  }
}
```

## Configuración Avanzada

### Configuración personalizada

```dart
final customConfig = ThemeConfig(
  light: myCustomLightTheme,
  dark: myCustomDarkTheme,
  storageKey: 'mi_app_theme',
  defaultThemeMode: ThemeMode.light,
  localization: ThemeLocalization(
    dialogTitle: 'Elegir Tema',
    lightThemeName: 'Claro',
    darkThemeName: 'Oscuro',
    systemThemeName: 'Auto',
    // ... más personalizaciones
  ),
);

// En main()
ProviderScope(
  overrides: [
    themeConfigProvider.overrideWithValue(customConfig),
  ],
  child: MyApp(),
)
```

### Temas personalizados

```dart
// Define tus temas personalizados
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  // tu configuración personalizada...
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  // tu configuración personalizada...
);

final config = ThemeConfig(
  light: lightTheme,
  dark: darkTheme,
);
```

### Localización personalizada

```dart
final spanishLocalization = ThemeLocalization(
  dialogTitle: 'Seleccionar Tema',
  cancelButton: 'Cancelar',
  selectorTooltip: 'Cambiar Tema',
  lightThemeName: 'Claro',
  darkThemeName: 'Oscuro',
  systemThemeName: 'Sistema',
  lightThemeDescription: 'Usar tema claro',
  darkThemeDescription: 'Usar tema oscuro',
  systemThemeDescription: 'Seguir sistema',
  themeTitle: 'Apariencia',
);

final config = ThemeConfig(
  localization: spanishLocalization,
);
```

## API Reference

### ThemeConfig

Clase de configuración principal:

```dart
ThemeConfig({
  ThemeData? light,              // Tema claro
  ThemeData? dark,               // Tema oscuro
  String storageKey,             // Clave para persistencia
  ThemeMode defaultThemeMode,    // Tema por defecto
  ThemeLocalization localization, // Textos localizados
})
```

### ThemeSelector

Widget para selección de tema:

```dart
// Constructor principal
ThemeSelector({
  bool asIconButton = false,
  IconData? customIcon,
  ThemeConfig? customConfig,
  void Function(ThemeMode)? onThemeChanged,
})

// Factory constructors
ThemeSelector.iconButton()
ThemeSelector.listTile()
```

### ThemeDisplay

Widget para mostrar tema actual:

```dart
ThemeDisplay({
  ThemeConfig? customConfig,
  TextStyle? textStyle,
  bool showIcon = true,
  double spacing = 8.0,
  IconData? customIcon,
})
```

### Providers disponibles

```dart
themeProvider                 // StateNotifierProvider<ThemeNotifier, ThemeMode>
themeConfigProvider          // Provider<ThemeConfig>
isDarkThemeProvider          // Provider<bool>
isLightThemeProvider         // Provider<bool>
isSystemThemeProvider        // Provider<bool>
themeDisplayNameProvider     // Provider<String>
currentLightThemeProvider    // Provider<ThemeData>
currentDarkThemeProvider     // Provider<ThemeData>
```

### ThemeNotifier

Métodos disponibles:

```dart
Future<void> setTheme(ThemeMode themeMode)
Future<void> toggleTheme()
Future<void> resetTheme()
String get themeDisplayName
bool get isDark
bool get isLight
bool get isSystem
```

## Ejemplo Completo

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_manager/theme_manager.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        themeConfigProvider.overrideWithValue(
          ThemeConfig(
            light: ThemeData.light(useMaterial3: true),
            dark: ThemeData.dark(useMaterial3: true),
            storageKey: 'my_app_theme',
            defaultThemeMode: ThemeMode.system,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final lightTheme = ref.watch(currentLightThemeProvider);
    final darkTheme = ref.watch(currentDarkThemeProvider);

    return MaterialApp(
      title: 'Theme Manager Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Manager Demo'),
        actions: [
          ThemeSelector.iconButton(),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Configuraciones'),
          ),
          ThemeSelector.listTile(),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text('Tema actual:'),
                ThemeDisplay(),
                SizedBox(height: 10),
                ThemeChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Mejores Prácticas

Para patrones de uso avanzados, personalización de widgets y mejores prácticas, consulta [BEST_PRACTICES.md](BEST_PRACTICES.md).

## Licencia

MIT
