import 'package:base_project/app.dart';
import 'package:base_project/src/config/app_config.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configDev();
  await setupAndRunApp();
}

Future<void> configDev() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.dev);
}
