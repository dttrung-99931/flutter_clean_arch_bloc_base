import 'package:flutter/material.dart';
import 'package:flutter_base_app/config/app_nav_observer.dart';
import 'package:flutter_base_app/config/app_router.dart';
import 'package:flutter_base_app/features/auth/domain/entities/response/user.dart';
import 'package:flutter_base_app/shared/enums/app_mode.dart';

class Global {
  static GlobalKey<NavigatorState> get globalKey => AppRouter.navigationKey;
  static BuildContext get context => globalKey.currentContext!;

  static String get currentRoute => AppNavObserver.currentRoute;

  static List<OverlayEntry> overlayEntries = [];

  static User? _user;
  static User? get user => _user;
  static bool get userLoaded => _user != null;
  static void setUser(User detail) {
    _user = detail;
  }

  static AppMode? appMode;
  static bool get isUserMode {
    return appMode == null || appMode == AppMode.user;
  }

  static ValueNotifier<int> mainPageIndexNotifier = ValueNotifier(0);
}
