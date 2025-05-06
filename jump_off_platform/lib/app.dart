import 'core/config/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/utils/helpers/app_state_notifier.dart';
import 'core/constants/string_constants.dart'; // Added for app_name
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, appState, child) {
      return MaterialApp(
        title: app_name, // Using constant app_name
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: routes,
      );
    });
  }
} 