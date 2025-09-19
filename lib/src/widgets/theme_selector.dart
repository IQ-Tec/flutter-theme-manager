import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/theme_config_provider.dart';
import '../models/theme_config.dart';
import '../enums/theme_mode_extension.dart';

/// A customizable theme selector widget
class ThemeSelector extends ConsumerWidget {
  /// Whether to show as an icon button or list tile
  final bool asIconButton;
  
  /// Custom icon for icon button mode
  final IconData? customIcon;
  
  /// Custom theme configuration (overrides provider config)
  final ThemeConfig? customConfig;
  
  /// Callback when theme is changed
  final void Function(ThemeMode)? onThemeChanged;

  const ThemeSelector({
    super.key,
    this.asIconButton = false,
    this.customIcon,
    this.customConfig,
    this.onThemeChanged,
  });

  /// Factory constructor for icon button
  const ThemeSelector.iconButton({
    super.key,
    this.customIcon,
    this.customConfig,
    this.onThemeChanged,
  }) : asIconButton = true;

  /// Factory constructor for list tile
  const ThemeSelector.listTile({
    super.key,
    this.customConfig,
    this.onThemeChanged,
  }) : asIconButton = false,
       customIcon = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final configFromProvider = ref.watch(themeConfigProvider);
    final config = customConfig ?? configFromProvider;

    if (asIconButton) {
      return IconButton(
        icon: Icon(customIcon ?? currentTheme.icon),
        tooltip: config.localization.selectorTooltip,
        onPressed: () => _showThemeDialog(context, ref, currentTheme, config),
      );
    }

    return ListTile(
      leading: Icon(currentTheme.icon),
      title: Text(config.localization.themeTitle),
      subtitle: Text(themeNotifier.themeDisplayName),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemeDialog(context, ref, currentTheme, config),
    );
  }

  void _showThemeDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentTheme,
    ThemeConfig config,
  ) {
    showDialog(
      context: context,
      builder: (context) => _ThemeDialog(
        currentTheme: currentTheme,
        config: config,
        onThemeSelected: (themeMode) {
          ref.read(themeProvider.notifier).setTheme(themeMode);
          onThemeChanged?.call(themeMode);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

/// Internal dialog widget for theme selection
class _ThemeDialog extends StatelessWidget {
  final ThemeMode currentTheme;
  final ThemeConfig config;
  final void Function(ThemeMode) onThemeSelected;

  const _ThemeDialog({
    required this.currentTheme,
    required this.config,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(config.localization.dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map((themeMode) {
          final isSelected = themeMode == currentTheme;

          return ListTile(
            leading: Icon(themeMode.icon),
            title: Text(_getThemeDisplayName(themeMode)),
            subtitle: Text(_getThemeDescription(themeMode)),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            selected: isSelected,
            onTap: () => onThemeSelected(themeMode),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(config.localization.cancelButton),
        ),
      ],
    );
  }

  String _getThemeDisplayName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return config.localization.lightThemeName;
      case ThemeMode.dark:
        return config.localization.darkThemeName;
      case ThemeMode.system:
        return config.localization.systemThemeName;
    }
  }

  String _getThemeDescription(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return config.localization.lightThemeDescription;
      case ThemeMode.dark:
        return config.localization.darkThemeDescription;
      case ThemeMode.system:
        return config.localization.systemThemeDescription;
    }
  }
}
