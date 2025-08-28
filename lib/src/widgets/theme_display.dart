import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../models/theme_config.dart';
import '../enums/theme_mode_extension.dart';

/// A simple widget to display the current theme
class ThemeDisplay extends ConsumerWidget {
  /// Custom theme configuration (overrides provider config)
  final ThemeConfig? customConfig;
  
  /// Custom text style
  final TextStyle? textStyle;
  
  /// Whether to show the icon
  final bool showIcon;
  
  /// Spacing between icon and text
  final double spacing;
  
  /// Custom icon
  final IconData? customIcon;

  const ThemeDisplay({
    super.key,
    this.customConfig,
    this.textStyle,
    this.showIcon = true,
    this.spacing = 8.0,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    
    final effectiveTextStyle = textStyle ?? 
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        );

    final children = <Widget>[];
    
    if (showIcon) {
      children.add(Icon(customIcon ?? currentTheme.icon));
      children.add(SizedBox(width: spacing));
    }
    
    children.add(
      Text(
        themeNotifier.themeDisplayName,
        style: effectiveTextStyle,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// A chip-style display for the current theme
class ThemeChip extends ConsumerWidget {
  /// Custom theme configuration (overrides provider config)
  final ThemeConfig? customConfig;
  
  /// Callback when the chip is tapped
  final VoidCallback? onTap;
  
  /// Custom chip color
  final Color? backgroundColor;
  
  /// Custom text color
  final Color? textColor;

  const ThemeChip({
    super.key,
    this.customConfig,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return ActionChip(
      avatar: Icon(
        currentTheme.icon,
        size: 18,
        color: textColor,
      ),
      label: Text(
        themeNotifier.themeDisplayName,
        style: TextStyle(color: textColor),
      ),
      onPressed: onTap,
      backgroundColor: backgroundColor,
    );
  }
}

/// A badge-style display for the current theme
class ThemeBadge extends ConsumerWidget {
  /// Custom theme configuration (overrides provider config)
  final ThemeConfig? customConfig;
  
  /// Callback when the badge is tapped
  final VoidCallback? onTap;

  const ThemeBadge({
    super.key,
    this.customConfig,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              currentTheme.icon,
              size: 16,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4),
            Text(
              currentTheme.name.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
