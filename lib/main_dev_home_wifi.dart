import 'package:base_project/app.dart';
import 'package:base_project/src/config/app_config.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configDevHome();
  await setupAndRunApp();
}

Future<void> configDevHome() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.devHomeWifi);
}
