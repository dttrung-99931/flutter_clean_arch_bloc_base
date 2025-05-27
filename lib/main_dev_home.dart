import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/src/config/app_config.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configDevHome();
  await setupAndRunApp();
}

Future<void> configDevHome() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.devHome);
}
