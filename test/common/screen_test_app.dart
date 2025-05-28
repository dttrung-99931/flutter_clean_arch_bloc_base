import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maingames_flutter_test/core/utils/utils.dart';
import 'package:maingames_flutter_test/global.dart';
import 'package:maingames_flutter_test/src/config/app_config.dart';
import 'package:maingames_flutter_test/src/config/app_translation.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/config/theme/app_theme.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';

class MaingamesTestApp extends StatelessWidget {
  const MaingamesTestApp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext _) {
    return GestureDetector(
      onTap: removeCurrentFocus,
      child: EasyLocalization(
        saveLocale: false, // Make EasyLocalization won't use SharePref
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
            builder: (_, __) {
              return AppThemeWidget(
                builder: (context) => MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  navigatorKey: Global.globalKey,
                  debugShowCheckedModeBanner: false,
                  title: AppConfig.config.appName,
                  home: child,
                  theme: AppTheme.themeOf(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
