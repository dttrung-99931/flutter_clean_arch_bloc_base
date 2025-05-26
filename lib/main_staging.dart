import 'package:base_project/src/config/app_config.dart';
import 'package:base_project/app.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configStaging();
  await setupAndRunApp();
}

Future<void> configStaging() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.staging);
}
