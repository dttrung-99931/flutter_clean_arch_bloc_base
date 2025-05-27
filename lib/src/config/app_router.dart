import 'package:maingames_flutter_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/src/features/payment/presentation/screens/payment_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Widget _buildScreen(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      // Auth
      case LoginScreen.route:
        return const LoginScreen();

      // Payment
      case PaymentScreen.route:
        return const PaymentScreen();
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

  static void _configUIForScreen(RouteSettings settings) {}

  static void _initLazyBloc(RouteSettings settings) {
    switch (settings.name) {
      default:
    }
  }
}
