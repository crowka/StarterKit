# lib/examples/custom_theme_demo.dart
import 'package:flutter/material.dart';
import '../core/config/theme/theme_constants.dart';
import '../core/providers/theme_provider.dart';

/// Example of using a custom theme for a specific app
class CustomThemeDemo extends StatelessWidget {
  const CustomThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom App Theme'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () => _showCustomPaletteOptions(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App-Specific Theme',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Custom Themed Button'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomPaletteOptions(BuildContext context) {
    // Define a custom palette for this specific app
    const customPalette = ColorPalette(
      primary: Color(0xFF3344FF),     // Royal Blue
      secondary: Color(0xFFFF9B7D),    // Coral
      tertiary: Color(0xFFFFC107),     // Yellow
      neutral: Color(0xFF8294A5),      // Grey-Blue
      accent1: Color(0xFF45B8D9),      // Turquoise
      accent2: Color(0xFF6B8E23),      // Olive Green
      background: Color(0xFFF7F4ED),   // Off-White
      surface: Color(0xFFFFFFFF),      // White
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Theme Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Use Custom App Theme'),
                onTap: () {
                  context.setCustomPalette(customPalette);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Use Global Platform Theme'),
                onTap: () {
                  context.setCustomPalette(null);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
