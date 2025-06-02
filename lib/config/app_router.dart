import 'package:another_flushbar/flushbar_route.dart';
import 'package:maingames_flutter_test/config/app_nav_observer.dart';
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();
  static NavigatorState get navigator => navigationKey.currentState!;

  static Widget _buildScreen(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      // Auth
      case LoginScreen.route:
        return const LoginScreen();

      // Home
      case HomeScreen.route:
        return const HomeScreen();
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

  static void hideDialog(BuildContext dialogContext) {
    navigator.pop(dialogContext);
  }

  static Future<T?> pushNamed<T extends Object?>(String routeName, {Object? args}) {
    hideAllSnackbars();
    return navigator.pushNamed(routeName, arguments: args);
  }

  static Future<T?> popAllAndPushNamed<T extends Object?>(String routeName) {
    hideAllSnackbars();
    return navigator.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  static void popUntilNamed<T extends Object?>(String routeName) {
    navigator.popUntil(ModalRoute.withName(routeName));
  }

  // TODO: fix, currently not working
  // static void popAllCurrentDialogs<T extends Object?>() {
  //   navigator.popUntil((route) => route is MaterialPageRoute);
  // }

  static void hideAllSnackbars() {
    navigator.popUntil((route) => route is! FlushbarRoute);
  }

  static void pushReplacementNamed(String routeName, {Object? args}) {
    navigator.pushReplacementNamed(routeName, arguments: args);
  }

  static void pop() {
    navigator.pop();
  }

  static Future<T?> swapCurrentAndPrevRoute<T extends Object?>({
    // Map<route name, udpated args>
    Map<String, dynamic> updatedArgs = const {},
  }) async {
    if (AppNavObserver.previousRoute != null) {
      String currentRoute = AppNavObserver.currentRoute;
      String previousRoute = AppNavObserver.previousRoute!;
      Object? currentRouteArgs = updatedArgs[currentRoute] ?? AppNavObserver.currentRouteArgs;
      Object? previousRouteArgs = updatedArgs[previousRoute] ?? AppNavObserver.previousRouteArgs;
      pop();
      pop();
      pushNamed(currentRoute, args: currentRouteArgs);
      return pushNamed(previousRoute, args: previousRouteArgs);
    }
    return null;
  }

  // like pushNamed and make sure unique screen existing in stack when one of two screens go to each other many times
  static Future<T?> pushNamedSafe<T extends Object?>(String routeName, {Object? args, bool showCommingSoon = true}) {
    if (AppNavObserver.previousRoute != routeName) {
      return pushNamed(routeName, args: args);
    } else {
      return swapCurrentAndPrevRoute(updatedArgs: {routeName: args});
    }
  }

  static void hideAllDialogs({List<String> ignoreDialogRoutes = const []}) {
    navigator.popUntil(
      (route) => (route is! DialogRoute || ignoreDialogRoutes.contains(route.settings.name)) || (!navigator.canPop()),
    );
  }
}
