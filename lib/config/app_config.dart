import 'dart:async';

import 'package:maingames_flutter_test/main.dart';
import 'package:maingames_flutter_test/main_dev.dart';
import 'package:maingames_flutter_test/main_staging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  AppConfig._({
    required this.appName,
    required this.flavor,
    required this.apiUrl,
    required this.logResponse,
    required this.logRequest,
    required this.logBloc,
  });
  final String appName;
  final AppFlavor flavor;
  final String apiUrl;
  final bool logResponse;
  final bool logRequest;
  final bool logBloc;
  bool get isDevelopment => [AppFlavor.dev].contains(flavor);
  bool get isDevelopmentDebug => isDevelopment && kDebugMode;

  static AppConfig? _config;
  static AppConfig get config {
    if (_config == null) throw Exception('AppConfig not set');
    return _config!;
  }

  static Future<void> loadConfig(AppFlavor flavor) async {
    await dotenv.load(fileName: flavor.envPath);
    _config = AppConfig._(
      flavor: flavor,
      appName: dotenv.env['appName']!,
      apiUrl: dotenv.env['apiUrl']!,
      logResponse: dotenv.env['logResponse']!.toLowerCase() == 'true',
      logRequest: dotenv.env['logRequest']!.toLowerCase() == 'true',
      logBloc: dotenv.env['logBloc']!.toLowerCase() == 'true',
    );
  }

  static Map<AppFlavor, Function()> configurerMap = {
    AppFlavor.dev: configDev,
    AppFlavor.staging: configStaging,
    AppFlavor.production: configProduction,
  };

  /// Auto config, use bundle app id to dertermine config env
  static Future<void> autoConfigByBundleId() async {
    AppFlavor env = await getFlavorByCurrentAppBundleId();
    await configurerMap[env]?.call();
  }

  static Future<AppFlavor> getFlavorByCurrentAppBundleId() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    String bundleId = info.packageName;
    if (bundleId.toLowerCase().contains('dev')) {
      return AppFlavor.dev;
    }
    if (bundleId.toLowerCase().contains('staging')) {
      return AppFlavor.staging;
    }
    return AppFlavor.production;
  }

  // Validate that the flavor matches the bundle id
  // This is used to ensure that the app is running in the correct environment
  Future<void> validateFlavorMatchingBundleId() async {
    final flavorByBundleId = await getFlavorByCurrentAppBundleId();
    bool isMathching = flavor == flavorByBundleId;
    assert(
      isMathching,
      'Native bundle id must contains corresponding env name. '
      'Ex: dev bundle id must contains "dev" => dev bundle id may be "app.test.dev"',
    );
  }
}

// ignore: constant_identifier_names
enum AppFlavor {
  dev,
  staging,
  production;

  String get envPath {
    switch (this) {
      case AppFlavor.dev:
        return 'assets/env/.env.dev';
      case AppFlavor.staging:
        return 'assets/env/.env.staging';
      case AppFlavor.production:
        return 'assets/env/.env';
    }
  }
}
