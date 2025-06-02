import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_base_app/core/cache/panda_cache_provider.dart';
import 'package:flutter_base_app/core/interceptors/api_log_interceptor.dart';
import 'package:flutter_base_app/core/interceptors/auth_interceptor.dart';
import 'package:flutter_base_app/core/utils/storage.dart';
import 'package:flutter_base_app/config/app_config.dart';
import 'package:flutter_base_app/config/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Used to quick assess to GetIt instead of call GetIt.instance
final GetIt getIt = GetIt.instance;

@InjectableInit(generateForDir: ["lib"])
Future<void> configureDependencies({void Function()? dependencyOverride}) async {
  getIt.init();
  dependencyOverride?.call();
  await getIt<Storage>().init();
}

// Provide dependencies used in whole app
@module
abstract class AppModuleDepedenciesProvider {
  @lazySingleton
  Dio provideNetworkDio(
    AuthInterceptor authInterceptor,
    ApiLogInterceptor apiLogInterceptor,
    CacheMaxStaleModifierInterceptor maxStaleModifierInterceptor, // Dio cache maxStale Modifier by url
    DioCacheInterceptor cacheInterceptor,
  ) {
    var baseOptions = BaseOptions(
      baseUrl: AppConfig.config.apiUrl,
      validateStatus: (status) {
        return [200, 201, 204, 404, 422, 401, 409].contains(status);
      },
    );
    final dio = Dio(baseOptions);
    dio.interceptors.addAll([
      authInterceptor,
      // maxStaleModifierInterceptor,
      // cacheInterceptor,
      apiLogInterceptor,
    ]);
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient httpClient) {
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
    return dio;
  }

  @lazySingleton
  Storage provideStorage(LocalStorage storage) {
    return Storage(storage);
  }
}
