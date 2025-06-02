import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/config/app_config.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configDev();
  await setupAndRunApp();
}

Future<void> configDev() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.dev);
}
