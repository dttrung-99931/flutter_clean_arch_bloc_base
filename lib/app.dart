import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:maingames_flutter_test/core/utils/utils.dart';
import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/config/app_bloc_observer.dart';
import 'package:maingames_flutter_test/src/config/app_config.dart';
import 'package:maingames_flutter_test/src/config/app_nav_observer.dart';
import 'package:maingames_flutter_test/src/config/app_router.dart';
import 'package:maingames_flutter_test/src/config/app_translation.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/screens/login_screen.dart';

Future<void> setupAndRunApp() async {
  final bining = WidgetsFlutterBinding.ensureInitialized();
  // Keep splash showing, splash will be removed in SplashScreen
  FlutterNativeSplash.preserve(widgetsBinding: bining);
  await setupApp();
  final initialRoute = await _getInitialRoute();
  runApp(PandaShopApp(initialRoute: initialRoute));
  FlutterNativeSplash.remove();
}

Future<String> _getInitialRoute() async {
  return LoginScreen.route;
}

Future<void> setupApp({bool isTest = false}) async {
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
  const PandaShopApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext _) {
    return GestureDetector(
      onTap: removeCurrentFocus,
      child: EasyLocalization(
        supportedLocales: AppTranslation.supportedLocales,
        path: AppTranslation.path,
        fallbackLocale: AppTranslation.en,
        startLocale: AppTranslation.en,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<LoginBloc>(),
            ),
          ],
          child: ScreenUtilInit(
            designSize: const Size(540, 960),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return AppThemeWidget(
                builder: (context) => MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  navigatorKey: Global.globalKey,
                  debugShowCheckedModeBanner: false,
                  title: AppConfig.config.appName,
                  onGenerateRoute: AppRouter.onGenerateRoute,
                  theme: AppTheme.themeOf(context),
                  initialRoute: initialRoute,
                  navigatorObservers: [AppNavObserver()],
                ),
              );
            },
          ),
        ),
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
