import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/request/login_request_model.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/response/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

@module
abstract class AuthRepoteDatasourceProvider {
  @lazySingleton
  AuthDatasource provideAuthDatasource(Dio dio) {
    return _AuthDatasource(dio);
    // return TestAuthDataSource();
  }
}

@RestApi()
abstract class AuthDatasource {
  @POST('/v1/Users/login')
  Future<BaseResponse<LoginResponseModel?>> login(@Body() LoginRequestModel param);
}
