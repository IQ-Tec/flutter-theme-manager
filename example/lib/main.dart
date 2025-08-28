import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_manager/theme_manager.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        themeConfigProvider.overrideWithValue(
          ThemeConfig(
            light: _createLightTheme(),
            dark: _createDarkTheme(),
            storageKey: 'example_app_theme',
            defaultThemeMode: ThemeMode.system,
            localization: const ThemeLocalization(
              dialogTitle: 'Seleccionar Tema',
              lightThemeName: 'Claro',
              darkThemeName: 'Oscuro',
              systemThemeName: 'Sistema',
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

ThemeData _createLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 2,
    ),
    cardTheme: const CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}

ThemeData _createDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 2,
    ),
    cardTheme: const CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final lightTheme = ref.watch(currentLightThemeProvider);
    final darkTheme = ref.watch(currentDarkThemeProvider);

    return MaterialApp(
      title: 'Theme Manager Example',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Manager Example'),
        actions: [
          ThemeSelector.iconButton(),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ConfigurationSection(),
            SizedBox(height: 24),
            _DisplaySection(),
            SizedBox(height: 24),
            _ControlSection(),
          ],
        ),
      ),
    );
  }
}

class _ConfigurationSection extends StatelessWidget {
  const _ConfigurationSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuración',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ThemeSelector.listTile(),
          ],
        ),
      ),
    );
  }
}

class _DisplaySection extends StatelessWidget {
  const _DisplaySection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Widgets de Display',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text('Display simple: '),
                ThemeDisplay(),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Text('Como chip: '),
                ThemeChip(),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Text('Como badge: '),
                ThemeBadge(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlSection extends ConsumerWidget {
  const _ControlSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final currentTheme = ref.watch(themeProvider);
    final isDark = ref.watch(isDarkThemeProvider);
    final isLight = ref.watch(isLightThemeProvider);
    final isSystem = ref.watch(isSystemThemeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Control Programático',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => themeNotifier.setTheme(ThemeMode.light),
                  child: const Text('Tema Claro'),
                ),
                ElevatedButton(
                  onPressed: () => themeNotifier.setTheme(ThemeMode.dark),
                  child: const Text('Tema Oscuro'),
                ),
                ElevatedButton(
                  onPressed: () => themeNotifier.setTheme(ThemeMode.system),
                  child: const Text('Sistema'),
                ),
                OutlinedButton(
                  onPressed: () => themeNotifier.toggleTheme(),
                  child: const Text('Alternar'),
                ),
                OutlinedButton(
                  onPressed: () => themeNotifier.resetTheme(),
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Estado actual:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Tema: $currentTheme'),
            Text('Es oscuro: $isDark'),
            Text('Es claro: $isLight'),
            Text('Es sistema: $isSystem'),
          ],
        ),
      ),
    );
  }
}
