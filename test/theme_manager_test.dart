import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_manager/theme_manager.dart';

void main() {
  group('ThemeManager Tests', () {
    testWidgets('ThemeSelector should display current theme', (WidgetTester tester) async {
      final config = ThemeConfig();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeConfigProvider.overrideWithValue(config),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ThemeSelector.listTile(),
            ),
          ),
        ),
      );

      expect(find.text('Tema'), findsOneWidget);
      expect(find.text('Sistema'), findsOneWidget);
    });

    testWidgets('ThemeDisplay should show current theme info', (WidgetTester tester) async {
      final config = ThemeConfig();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeConfigProvider.overrideWithValue(config),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: ThemeDisplay(),
            ),
          ),
        ),
      );

      expect(find.text('Sistema'), findsOneWidget);
      expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
    });

    test('ThemeService should initialize properly', () {
      const storageKey = 'test_theme';
      final service = ThemeService(storageKey: storageKey);
      
      expect(service, isNotNull);
      expect(service, isA<ThemeService>());
    });

    test('ThemeConfig should have default values', () {
      const config = ThemeConfig();
      
      expect(config.storageKey, 'theme_mode');
      expect(config.defaultThemeMode, ThemeMode.system);
      expect(config.localization.dialogTitle, 'Seleccionar Tema');
    });

    test('ThemeModeExtension should provide correct display names', () {
      expect(ThemeMode.light.displayName, 'Claro');
      expect(ThemeMode.dark.displayName, 'Oscuro');
      expect(ThemeMode.system.displayName, 'Sistema');
      
      expect(ThemeMode.light.icon, Icons.light_mode);
      expect(ThemeMode.dark.icon, Icons.dark_mode);
      expect(ThemeMode.system.icon, Icons.auto_awesome);
      
      expect(ThemeMode.light.isLight, true);
      expect(ThemeMode.dark.isDark, true);
      expect(ThemeMode.system.isSystem, true);
    });
  });
}
