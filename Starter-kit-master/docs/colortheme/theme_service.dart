#Save to: lib/shared/services/theme_service.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/config/theme/theme_constants.dart';

/// Keys for shared preferences
const String _selectedPaletteKey = 'selected_palette';
const String _themeModeKey = 'theme_mode';

/// Theme service to manage app theming
class ThemeService extends ChangeNotifier {
  late SharedPreferences _prefs;
  
  // Default values
  ThemeMode _themeMode = ThemeMode.system;
  int _selectedPaletteIndex = 0;
  
  // Custom palette for app-specific theming
  ColorPalette? _customPalette;
  
  /// Available palettes
  final List<ColorPalette> _palettes = [
    ThemeConstants.palette1,
    ThemeConstants.palette2,
    ThemeConstants.palette3,
  ];
  
  /// The current theme mode (light, dark, or system)
  ThemeMode get themeMode => _themeMode;
  
  /// The index of the currently selected palette
  int get selectedPaletteIndex => _selectedPaletteIndex;
  
  /// All available palettes
  List<ColorPalette> get palettes => _palettes;
  
  /// The currently active palette
  ColorPalette get activePalette => 
      _customPalette ?? _palettes[_selectedPaletteIndex];
  
  /// Sets a custom palette for this specific app
  set customPalette(ColorPalette? palette) {
    _customPalette = palette;
    notifyListeners();
  }
  
  /// Initialize the theme service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadPreferences();
  }
  
  /// Load saved preferences
  void _loadPreferences() {
    // Load theme mode
    final themeModeString = _prefs.getString(_themeModeKey);
    if (themeModeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
    }
    
    // Load selected palette
    final paletteIndex = _prefs.getInt(_selectedPaletteKey);
    if (paletteIndex != null && paletteIndex < _palettes.length) {
      _selectedPaletteIndex = paletteIndex;
    }
    
    notifyListeners();
  }
  
  /// Switch to a different palette by index
  void switchPalette(int index) {
    if (index >= 0 && index < _palettes.length) {
      _selectedPaletteIndex = index;
      _prefs.setInt(_selectedPaletteKey, index);
      notifyListeners();
    }
  }
  
  /// Switch theme mode (light/dark/system)
  void switchThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs.setString(_themeModeKey, mode.toString());
    notifyListeners();
  }
  
  /// Get the light theme data
  ThemeData getLightTheme() {
    final palette = activePalette;
    final colorScheme = palette.toColorScheme();
    
    return _createThemeData(colorScheme);
  }
  
  /// Get the dark theme data
  ThemeData getDarkTheme() {
    final palette = activePalette;
    final darkPalette = palette.toDark();
    final colorScheme = darkPalette.toColorScheme(isDark: true);
    
    return _createThemeData(colorScheme);
  }
  
  /// Create a ThemeData instance from a ColorScheme
  ThemeData _createThemeData(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Apply the colorScheme to specific components
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      
      cardTheme: CardTheme(
        color: colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Set default text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          letterSpacing: 0.4,
          color: colorScheme.onSurface,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
