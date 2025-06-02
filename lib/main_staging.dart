import 'package:maingames_flutter_test/config/app_config.dart';
import 'package:maingames_flutter_test/app.dart';
import 'package:flutter/widgets.dart';

void main() async {
  await configStaging();
  await setupAndRunApp();
}

Future<void> configStaging() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig(AppFlavor.staging);
}
