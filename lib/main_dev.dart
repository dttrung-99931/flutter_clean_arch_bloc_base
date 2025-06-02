import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/config/app_config.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configDev();
  await setupAndRunApp();
}

Future<void> configDev() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.dev);
}
