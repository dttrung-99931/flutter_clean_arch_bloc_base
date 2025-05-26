import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:base_project/core/utils/utils.dart';
import 'package:base_project/global.dart';
import 'package:base_project/src/config/app_bloc_observer.dart';
import 'package:base_project/src/config/app_config.dart';
import 'package:base_project/src/config/app_nav_observer.dart';
import 'package:base_project/src/config/app_router.dart';
import 'package:base_project/src/config/app_translation.dart';
import 'package:base_project/src/config/di/injection.dart';
import 'package:base_project/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> setupAndRunApp() async {
  await setupApp();
  runApp(EasyLocalization(
    supportedLocales: AppTranslation.supportedLocales,
    path: AppTranslation.path,
    fallbackLocale: AppTranslation.ja,
    startLocale: AppTranslation.ja,
    child: const PandaShopApp(),
  ));
}

Future<void> setupApp({bool isTest = false}) async {
  final bining = WidgetsFlutterBinding.ensureInitialized();
  // Keep splash showing, splash will be removed in SplashScreen
  FlutterNativeSplash.preserve(widgetsBinding: bining);
  if (!isTest) {
    await AppConfig.config.validateFlavorMatchingBundleId();
  }
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await configureDependencies();
  HttpOverrides.global = PandaHttpOverrides();
  if (AppConfig.config.logBloc) {
    Bloc.observer = AppBlocObserver();
  }
}

class PandaShopApp extends StatelessWidget {
  const PandaShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeCurrentFocus,
      child: ScreenUtilInit(
        designSize: const Size(540, 960),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return AppThemeWidget(
            builder: (themeContext) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              navigatorKey: Global.globalKey,
              debugShowCheckedModeBanner: false,
              title: AppConfig.config.appName,
              onGenerateRoute: AppRouter.onGenerateRoute,
              theme: AppTheme.themeOf(themeContext),
              initialRoute: AppRouter.initialRouter,
              navigatorObservers: [AppNavObserver()],
            ),
          );
        },
      ),
    );
  }
}

// To fix CERTIFICATE_VERIFY_FAILED error
class PandaHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
