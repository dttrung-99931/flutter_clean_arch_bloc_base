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
import 'package:maingames_flutter_test/core/cache/panda_cache_provider.dart'
    as _i132;
import 'package:maingames_flutter_test/core/interceptors/api_log_interceptor.dart'
    as _i990;
import 'package:maingames_flutter_test/core/interceptors/auth_interceptor.dart'
    as _i144;
import 'package:maingames_flutter_test/core/utils/network/network_info.dart'
    as _i1068;
import 'package:maingames_flutter_test/core/utils/network/network_info_impl.dart'
    as _i360;
import 'package:maingames_flutter_test/core/utils/storage.dart' as _i606;
import 'package:maingames_flutter_test/src/config/di/injection.dart' as _i149;
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_remote_data_soruce.dart'
    as _i1002;
import 'package:maingames_flutter_test/src/features/auth/data/repositories/auth_repo_impl.dart'
    as _i399;
import 'package:maingames_flutter_test/src/features/auth/domain/repositories/auth_repo.dart'
    as _i317;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/check_login_usecase.dart'
    as _i1015;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/get_remember_login_email_usecase.dart'
    as _i644;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/login_usecase.dart'
    as _i117;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/logout_usecase.dart'
    as _i622;
import 'package:maingames_flutter_test/src/features/auth/domain/use_cases/sign_up_usecase.dart'
    as _i708;
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart'
    as _i168;
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart'
    as _i778;
import 'package:maingames_flutter_test/src/features/home/presentation/bloc/home_bloc.dart'
    as _i476;
import 'package:maingames_flutter_test/src/features/main/presentation/blocs/main/main_bloc.dart'
    as _i918;
import 'package:maingames_flutter_test/src/features/main/presentation/blocs/main/main_bloc_communicaton.dart'
    as _i43;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final cacheProvider = _$CacheProvider();
    final appModuleDepedenciesProvider = _$AppModuleDepedenciesProvider();
    final authRepoteDatasourceProvider = _$AuthRepoteDatasourceProvider();
    gh.lazySingleton<_i990.ApiLogInterceptor>(() => _i990.ApiLogInterceptor());
    gh.lazySingleton<_i695.CacheStore>(() => cacheProvider.provideCacheStore());
    gh.lazySingleton<_i476.HomeBloc>(() => _i476.HomeBloc());
    gh.lazySingleton<_i43.MainCommunication>(() => _i43.MainCommunication());
    gh.lazySingleton<_i606.LocalStorage>(() => _i606.SharePrefLocalStorage());
    gh.lazySingleton<_i1068.NetworkInfo>(() => _i360.NetworkInfoImpl());
    gh.lazySingleton<_i606.Storage>(
      () =>
          appModuleDepedenciesProvider.provideStorage(gh<_i606.LocalStorage>()),
    );
    gh.lazySingleton<_i695.CacheOptions>(
      () => cacheProvider.provideBaseCacheOptions(gh<_i695.CacheStore>()),
    );
    gh.lazySingleton<_i144.AuthInterceptor>(
      () => _i144.AuthInterceptor(gh<_i606.Storage>()),
    );
    gh.lazySingleton<_i622.LogoutUseCase>(
      () => _i622.LogoutUseCase(gh<_i606.Storage>()),
    );
    gh.lazySingleton<_i1015.CheckLoginUseCase>(
      () => _i1015.CheckLoginUseCase(gh<_i606.Storage>()),
    );
    gh.lazySingleton<_i644.GetRememberLoginEmailUserCase>(
      () => _i644.GetRememberLoginEmailUserCase(gh<_i606.Storage>()),
    );
    gh.lazySingleton<_i918.MainBloc>(() => _i918.MainBloc(gh<_i606.Storage>()));
    gh.lazySingleton<_i132.CacheMaxStaleModifierInterceptor>(
      () => cacheProvider.provideCacheMaxStaleModifierInterceptor(
        gh<_i695.CacheOptions>(),
      ),
    );
    gh.lazySingleton<_i695.DioCacheInterceptor>(
      () => cacheProvider.provideDioCacheInterceptor(gh<_i695.CacheOptions>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => appModuleDepedenciesProvider.provideNetworkDio(
        gh<_i144.AuthInterceptor>(),
        gh<_i990.ApiLogInterceptor>(),
        gh<_i132.CacheMaxStaleModifierInterceptor>(),
        gh<_i695.DioCacheInterceptor>(),
      ),
    );
    gh.lazySingleton<_i1002.AuthRepoteDatasource>(
      () => authRepoteDatasourceProvider.provideAuthRepoteDatasource(
        gh<_i361.Dio>(),
      ),
    );
    gh.lazySingleton<_i317.AuthRepo>(
      () => _i399.AuthRepoImpl(gh<_i1002.AuthRepoteDatasource>()),
    );
    gh.lazySingleton<_i117.EmailLoginUseCase>(
      () => _i117.EmailLoginUseCase(gh<_i317.AuthRepo>(), gh<_i606.Storage>()),
    );
    gh.lazySingleton<_i708.SignUpUseCase>(
      () => _i708.SignUpUseCase(gh<_i317.AuthRepo>()),
    );
    gh.lazySingleton<_i168.LoginBloc>(
      () => _i168.LoginBloc(
        gh<_i117.EmailLoginUseCase>(),
        gh<_i1015.CheckLoginUseCase>(),
        gh<_i622.LogoutUseCase>(),
        gh<_i644.GetRememberLoginEmailUserCase>(),
      ),
    );
    gh.lazySingleton<_i778.SignUpBloc>(
      () => _i778.SignUpBloc(gh<_i708.SignUpUseCase>()),
    );
    return this;
  }
}

class _$CacheProvider extends _i132.CacheProvider {}

class _$AppModuleDepedenciesProvider
    extends _i149.AppModuleDepedenciesProvider {}

class _$AuthRepoteDatasourceProvider
    extends _i1002.AuthRepoteDatasourceProvider {}
