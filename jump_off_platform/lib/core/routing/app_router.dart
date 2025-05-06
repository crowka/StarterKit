// IMPORTANT: Imports in this file need to be updated after screen files are moved.
// routes for the app
import 'package:jump_off_platform/features/home/presentation/pages/home_screen.dart';
import 'package:jump_off_platform/features/onboarding/presentation/pages/authentication_screen.dart';
import 'package:jump_off_platform/features/app_init/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case '/auth':
      return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
} 