// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart' as _i695;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:maingames_flutter_test/core/cache/panda_cache_provider.dart'
    as _i364;
import 'package:maingames_flutter_test/core/interceptors/api_log_interceptor.dart'
    as _i67;
import 'package:maingames_flutter_test/core/interceptors/auth_interceptor.dart'
    as _i707;
import 'package:maingames_flutter_test/core/utils/network/network_info.dart'
    as _i415;
import 'package:maingames_flutter_test/core/utils/network/network_info_impl.dart'
    as _i410;
import 'package:maingames_flutter_test/core/utils/storage.dart' as _i872;
import 'package:maingames_flutter_test/src/config/di/injection.dart' as _i895;
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_data_source.dart'
    as _i840;
import 'package:maingames_flutter_test/src/features/auth/data/repositories/auth_repo_impl.dart'
    as _i868;
import 'package:maingames_flutter_test/src/features/auth/domain/repositories/auth_repo.dart'
    as _i1071;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/check_login_usecase.dart'
    as _i869;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/get_remember_login_email_usecase.dart'
    as _i278;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/login_usecase.dart'
    as _i780;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/logout_usecase.dart'
    as _i93;
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart'
    as _i1067;
import 'package:maingames_flutter_test/src/features/payment/presentation/blocs/payment_bloc.dart'
    as _i1036;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final cacheProvider = _$CacheProvider();
    final appModuleDepedenciesProvider = _$AppModuleDepedenciesProvider();
    final authRepoteDatasourceProvider = _$AuthRepoteDatasourceProvider();
    gh.lazySingleton<_i67.ApiLogInterceptor>(() => _i67.ApiLogInterceptor());
    gh.lazySingleton<_i695.CacheStore>(() => cacheProvider.provideCacheStore());
    gh.lazySingleton<_i415.NetworkInfo>(() => _i410.NetworkInfoImpl());
    gh.lazySingleton<_i695.CacheOptions>(
        () => cacheProvider.provideBaseCacheOptions(gh<_i695.CacheStore>()));
    gh.lazySingleton<_i872.LocalStorage>(() => _i872.SharePrefLocalStorage());
    gh.lazySingleton<_i364.CacheMaxStaleModifierInterceptor>(() => cacheProvider
        .provideCacheMaxStaleModifierInterceptor(gh<_i695.CacheOptions>()));
    gh.lazySingleton<_i695.DioCacheInterceptor>(() =>
        cacheProvider.provideDioCacheInterceptor(gh<_i695.CacheOptions>()));
    gh.lazySingleton<_i872.Storage>(() =>
        appModuleDepedenciesProvider.provideStorage(gh<_i872.LocalStorage>()));
    gh.factory<_i1036.PaymentBloc>(
        () => _i1036.PaymentBloc(gh<_i872.Storage>()));
    gh.lazySingleton<_i707.AuthInterceptor>(
        () => _i707.AuthInterceptor(gh<_i872.Storage>()));
    gh.lazySingleton<_i93.LogoutUseCase>(
        () => _i93.LogoutUseCase(gh<_i872.Storage>()));
    gh.lazySingleton<_i869.CheckLoginUseCase>(
        () => _i869.CheckLoginUseCase(gh<_i872.Storage>()));
    gh.lazySingleton<_i278.GetRememberLoginEmailUserCase>(
        () => _i278.GetRememberLoginEmailUserCase(gh<_i872.Storage>()));
    gh.lazySingleton<_i361.Dio>(
        () => appModuleDepedenciesProvider.provideNetworkDio(
              gh<_i707.AuthInterceptor>(),
              gh<_i67.ApiLogInterceptor>(),
              gh<_i364.CacheMaxStaleModifierInterceptor>(),
              gh<_i695.DioCacheInterceptor>(),
            ));
    gh.lazySingleton<_i840.AuthDatasource>(() =>
        authRepoteDatasourceProvider.provideAuthDatasource(gh<_i361.Dio>()));
    gh.lazySingleton<_i1071.AuthRepo>(
        () => _i868.AuthRepoImpl(gh<_i840.AuthDatasource>()));
    gh.lazySingleton<_i780.EmailLoginUseCase>(() => _i780.EmailLoginUseCase(
          gh<_i1071.AuthRepo>(),
          gh<_i872.Storage>(),
        ));
    gh.factory<_i1067.LoginBloc>(() => _i1067.LoginBloc(
          gh<_i780.EmailLoginUseCase>(),
          gh<_i93.LogoutUseCase>(),
          gh<_i869.CheckLoginUseCase>(),
          gh<_i278.GetRememberLoginEmailUserCase>(),
        ));
    return this;
  }
}

class _$CacheProvider extends _i364.CacheProvider {}

class _$AppModuleDepedenciesProvider
    extends _i895.AppModuleDepedenciesProvider {}

class _$AuthRepoteDatasourceProvider
    extends _i840.AuthRepoteDatasourceProvider {}
