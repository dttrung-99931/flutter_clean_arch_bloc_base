import 'package:base_project/src/features/auth/presentation/screens/login_screen.dart';
import 'package:base_project/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:base_project/src/features/main/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String get initialRouter => MainScreen.router;

  static Widget _buildScreen(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      // Auth
      case LoginScreen.router:
        return const LoginScreen();
      case SignUpScreen.router:
        return const SignUpScreen();

      // Main
      case MainScreen.router:
        return const MainScreen();
    }
    return const SizedBox.shrink();
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    _configUIForScreen(settings);
    _initLazyBloc(settings);
    return MaterialPageRoute(
      builder: (context) {
        return _buildScreen(settings, context);
      },
      settings: settings,
    );
  }

  static void _configUIForScreen(RouteSettings settings) {
    if (![MainScreen.router].contains(settings.name)) {
      // Hide status bar
      // TODO: do not hide system nav bar
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      // SystemChrome.setSystemUIOverlayStyle(
      //   const SystemUiOverlayStyle(statusBarColor: AppColors.primary),
      // );
    } else {
      // Show status bar again
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // SystemChrome.setSystemUIOverlayStyle(
      //   const SystemUiOverlayStyle(statusBarColor: EVMColors.blueGreyDark, statusBarBrightness: Brightness.light),
      // );
    }
  }

  static void _initLazyBloc(RouteSettings settings) {
    switch (settings.name) {
      default:
    }
  }
}
