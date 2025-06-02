import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base_app/core/models/base_response.dart';
import 'package:flutter_base_app/features/auth/data/models/request/login_request_model.dart';
import 'package:flutter_base_app/features/auth/data/models/response/login_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

@module
abstract class AuthRepoteDatasourceProvider {
  @lazySingleton
  AuthDatasource provideAuthDatasource(Dio dio) {
    return _AuthDatasource(dio);
  }
}

@RestApi()
abstract class AuthDatasource {
  @POST('/v1/Users/login')
  Future<BaseResponse<LoginModel?>> login(@Body() LoginRequestModel param);
}
