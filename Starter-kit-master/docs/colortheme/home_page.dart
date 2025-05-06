
lib/features/onboarding/presentation/pages/home_page.dart
  import 'package:flutter/material.dart';
import '../../../../core/providers/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () => _showThemeModeSelector(context),
          ),
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => _showPaletteSelector(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Jump-Off Platform',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Card Title',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is a card with some content that demonstrates the current theme.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeModeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Theme Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Light'),
                leading: const Icon(Icons.brightness_5),
                onTap: () {
                  context.switchThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark'),
                leading: const Icon(Icons.brightness_3),
                onTap: () {
                  context.switchThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('System'),
                leading: const Icon(Icons.brightness_auto),
                onTap: () {
                  context.switchThemeMode(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaletteSelector(BuildContext context) {
    final themeService = context.themeService;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Palette'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              themeService.palettes.length,
              (index) => ListTile(
                title: Text('Palette ${index + 1}'),
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: themeService.palettes[index].primary,
                    shape: BoxShape.circle,
                  ),
                ),
                onTap: () {
                  context.switchPalette(index);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
