# Save to: lib/core/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/services/theme_service.dart';
import '../config/theme/theme_constants.dart';

/// Extension to access theme service from BuildContext
extension ThemeProviderExtension on BuildContext {
  /// Get the theme service
  ThemeService get themeService => read<ThemeService>();
  
  /// Switch to a palette by index
  void switchPalette(int index) => read<ThemeService>().switchPalette(index);
  
  /// Switch theme mode
  void switchThemeMode(ThemeMode mode) => read<ThemeService>().switchThemeMode(mode);
  
  /// Get the current active palette
  ColorPalette get activePalette => read<ThemeService>().activePalette;
  
  /// Set a custom palette
  void setCustomPalette(ColorPalette palette) => 
      read<ThemeService>().customPalette = palette;
}

/// Theme provider widget that provides the theme service to the app
class ThemeProvider extends StatelessWidget {
  final Widget child;
  
  const ThemeProvider({Key? key, required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeService>(
      create: (_) => ThemeService()..init(),
      child: child,
    );
  }
}
