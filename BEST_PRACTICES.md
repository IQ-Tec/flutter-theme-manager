# Mejores Prácticas para Theme Manager

## Configuración Recomendada

### 1. Configuración Básica
```dart
// En tu main.dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Usar la configuración por defecto (más simple)
final themeManager = ThemeManager();
```

### 2. Configuración Personalizada
```dart
// Para mayor control
final themeManager = ThemeManager(
  config: ThemeConfig(
    storageKey: 'mi_app_theme',
    defaultTheme: ThemeMode.light,
    lightDisplayName: 'Modo Claro',
    darkDisplayName: 'Modo Oscuro',
    systemDisplayName: 'Automático',
  ),
);
```

## Patrones de Uso

### 1. En Pantallas Principales
```dart
// AppBar con selector de tema
AppBar(
  title: Text('Mi App'),
  actions: [
    ThemeSelector(showAsIcon: true), // Icono en AppBar
  ],
)
```

### 2. En Pantallas de Configuración
```dart
// Lista de configuraciones
Column(
  children: [
    ThemeSelector(), // ListTile completo
    // Otras configuraciones...
  ],
)
```

### 3. Para Mostrar el Tema Actual
```dart
// En widgets donde necesites mostrar el tema actual
Row(
  children: [
    Text('Tema actual: '),
    ThemeDisplay(),
  ],
)
```

## Estructura Recomendada del Proyecto

```
lib/
├── main.dart
├── app.dart                 # Configuración de MaterialApp
├── providers/
│   └── app_providers.dart   # Todos los providers globales
├── theme/
│   ├── app_theme.dart       # Tus ThemeData personalizados
│   └── colors.dart          # Colores de tu app
└── screens/
    ├── settings/
    │   └── settings_screen.dart
    └── ...
```

## Inicialización

### Opción 1: Simple (Recomendado)
```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: AppTheme.light,      // Tu tema claro
      darkTheme: AppTheme.dark,   // Tu tema oscuro
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
}
```

### Opción 2: Con Provider Personalizado
```dart
// Si necesitas más control
final customThemeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(
    config: ThemeConfig(
      storageKey: 'mi_app_especial_theme',
      defaultTheme: ThemeMode.dark,
    ),
  );
});
```

## Consejos de Rendimiento

1. **Usa `ref.watch` solo donde necesites reactividad**
   ```dart
   // ✅ Correcto - solo en MaterialApp
   final themeMode = ref.watch(themeProvider);
   
   // ❌ Evitar - en widgets que no necesitan reconstruirse
   ```

2. **Usa `ref.read` para acciones**
   ```dart
   // ✅ Para cambiar el tema
   onPressed: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.dark)
   ```

3. **Mantén los temas en archivos separados**
   ```dart
   // theme/app_theme.dart
   class AppTheme {
     static ThemeData get light => ThemeData(...);
     static ThemeData get dark => ThemeData(...);
   }
   ```

## Personalización de Widgets

### ThemeSelector Personalizado
```dart
// Si necesitas un selector con diseño diferente
class CustomThemeSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return SegmentedButton<ThemeMode>(
      segments: [
        ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode)),
        ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode)),
        ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.auto_awesome)),
      ],
      selected: {themeMode},
      onSelectionChanged: (Set<ThemeMode> selection) {
        ref.read(themeProvider.notifier).setTheme(selection.first);
      },
    );
  }
}
```

## Casos de Uso Comunes

### 1. Tema por Defecto según el Sistema
```dart
// El tema 'system' ya maneja esto automáticamente
final themeManager = ThemeManager(); // Usa ThemeMode.system por defecto
```

### 2. Persistencia Personalizada
```dart
// Si necesitas tu propio almacenamiento
final customThemeManager = ThemeManager(
  config: ThemeConfig(
    storageKey: 'mi_clave_unica',
  ),
);
```

### 3. Múltiples Instancias (Avanzado)
```dart
// Para casos muy específicos con múltiples configuraciones
final mainThemeProvider = StateNotifierProvider.family<ThemeNotifier, ThemeMode, String>(
  (ref, storageKey) => ThemeNotifier(
    config: ThemeConfig(storageKey: storageKey),
  ),
);
```

## Debugging

### Verificar el Tema Actual
```dart
// En cualquier ConsumerWidget
final currentTheme = ref.read(themeProvider);
print('Tema actual: $currentTheme');
```

### Verificar la Persistencia
```dart
// Para verificar que se guarda correctamente
final notifier = ref.read(themeProvider.notifier);
print('Nombre del tema: ${notifier.themeDisplayName}');
```
