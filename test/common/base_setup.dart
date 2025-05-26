import 'package:evievm_app/core/utils/storage.dart';
import 'package:evievm_app/main_dev_home_wifi.dart';
import 'package:evievm_app/src/config/di/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';

import 'mock_dio_adapter.dart';
import 'mock_storage.dart';

@GenerateMocks([DioAdapter])
Future<void> baseTestSetup() async {
  await configDevHome();
  await configureDependencies(dependencyOverride: () {
    getIt.registerTestDependecy<LocalStorage>(MockLocalStorage());
  });
}

extension GetItTestExt on GetIt {
  void registerTestDependecy<T extends Object>(T dependecy) {
    if (isRegistered<T>()) {
      unregister<T>();
    }
    registerSingleton<T>(dependecy);
  }
}
