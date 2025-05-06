# savelib/core/config/theme/theme_constants.dart

import 'package:flutter/material.dart';

/// Theme constants for the Jump-Off Platform
///
/// Contains predefined color palettes that can be used across different apps
class ThemeConstants {
  // Private constructor to prevent instantiation
  ThemeConstants._();

  /// Palette 1 - Earth Tones
  static const ColorPalette palette1 = ColorPalette(
    primary: Color(0xFF2B3F4E),     // Dark Blue-Gray
    secondary: Color(0xFF3E8C75),   // Teal
    tertiary: Color(0xFFD66853),    // Terracotta
    neutral: Color(0xFF8294A5),     // Light Blue-Gray
    accent1: Color(0xFFE9C37C),     // Gold
    accent2: Color(0xFF475B4F),     // Dark Green
    background: Color(0xFFF8F6F2),  // Off-White
    surface: Color(0xFFF4E5D7),     // Beige
  );

  /// Palette 2 - Modern Tech
  static const ColorPalette palette2 = ColorPalette(
    primary: Color(0xFF2B3F4E),     // Dark Navy
    secondary: Color(0xFF3A6EA5),   // Blue
    tertiary: Color(0xFFFFC107),    // Yellow
    neutral: Color(0xFFD3D3D3),     // Light Gray
    accent1: Color(0xFF333333),     // Dark Gray
    accent2: Color(0xFF6B8E23),     // Olive Green
    background: Color(0xFFF7F4ED),  // Off-White
    surface: Color(0xFFFFFFFF),     // White
  );

  /// Palette 3 - Ocean Breeze
  static const ColorPalette palette3 = ColorPalette(
    primary: Color(0xFF334AFF),     // Bright Blue
    secondary: Color(0xFFB8E5EB),   // Light Blue
    tertiary: Color(0xFF3344FF),    // Royal Blue
    neutral: Color(0xFFF2C699),     // Peach
    accent1: Color(0xFF45B8D9),     // Turquoise
    accent2: Color(0xFFFF9B7D),     // Coral
    background: Color(0xFFF7F4ED),  // White
    surface: Color(0xFF092442),     // Dark Navy
  );
}

/// Color palette model for consistent theming
class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color neutral;
  final Color accent1;
  final Color accent2;
  final Color background;
  final Color surface;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.neutral,
    required this.accent1,
    required this.accent2,
    required this.background,
    required this.surface,
  });

  /// Creates a dark version of this palette
  ColorPalette toDark() {
    return ColorPalette(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      neutral: neutral,
      accent1: accent1,
      accent2: accent2,
      background: Color.lerp(Colors.black, primary, 0.1)!,
      surface: Color.lerp(Colors.black, primary, 0.05)!,
    );
  }

  /// Convert this palette to a ColorScheme for light mode
  ColorScheme toColorScheme({bool isDark = false}) {
    return ColorScheme(
      primary: primary,
      primaryContainer: Color.lerp(primary, Colors.white, 0.3)!,
      secondary: secondary,
      secondaryContainer: Color.lerp(secondary, Colors.white, 0.3)!,
      tertiary: tertiary,
      tertiaryContainer: Color.lerp(tertiary, Colors.white, 0.3)!,
      surface: surface,
      background: background,
      error: Colors.red.shade700,
      onPrimary: _contrastColor(primary),
      onSecondary: _contrastColor(secondary),
      onTertiary: _contrastColor(tertiary),
      onSurface: _contrastColor(surface),
      onBackground: _contrastColor(background),
      onError: Colors.white,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  /// Returns either black or white depending on the background color
  Color _contrastColor(Color backgroundColor) {
    // Calculate luminance - if it's dark, use white text, if light use dark text
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
