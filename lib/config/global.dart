import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/config/app_nav_observer.dart';
import 'package:maingames_flutter_test/config/app_router.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/response/user.dart';
import 'package:maingames_flutter_test/shared/enums/app_mode.dart';

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
