lib/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'shared/services/theme_service.dart';
import 'features/onboarding/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Consumer<ThemeService>(
        builder: (context, themeService, _) {
          return MaterialApp(
            title: 'Jump-Off Platform',
            theme: themeService.getLightTheme(),
            darkTheme: themeService.getDarkTheme(),
            themeMode: themeService.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
