import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/test_auth_data_source.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

@module
abstract class AuthRepoteDatasourceProvider {
  @lazySingleton
  AuthDatasource provideAuthDatasource(Dio dio) {
    // return _AuthDatasource(dio);
    return TestAuthDataSource();
  }
}

@RestApi()
abstract class AuthDatasource {
  @POST('/v1/Users/login')
  Future<BaseResponse<LoginResponseDto?>> login(@Body() LoginRequestDto param);
}
