import 'package:base_project/src/config/app_config.dart';
import 'package:base_project/app.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configProduction();
  await setupAndRunApp();
}

Future<void> configProduction() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.production);
}
