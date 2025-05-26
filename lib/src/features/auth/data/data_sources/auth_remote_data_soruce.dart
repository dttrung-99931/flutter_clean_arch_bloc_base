import 'package:dio/dio.dart';
import 'package:base_project/core/model/base_response.dart';
import 'package:base_project/src/features/auth/data/models/response/user_detail_model.dart';
import 'package:base_project/src/features/auth/data/models/request/login_request_model.dart';
import 'package:base_project/src/features/auth/data/models/request/sign_up_request_model.dart';
import 'package:base_project/src/features/auth/data/models/response/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/request/user_profile_request_model.dart';

part 'auth_remote_data_soruce.g.dart';

@module
abstract class AuthRepoteDatasourceProvider {
  @lazySingleton
  AuthRepoteDatasource provideAuthRepoteDatasource(Dio dio) {
    return _AuthRepoteDatasource(dio);
  }
}

@RestApi()
abstract class AuthRepoteDatasource {
  @POST('/v1/Users/login')
  Future<BaseResponse<LoginResponseModel?>> login(@Body() LoginRequestModel param);

  @POST('/v1/Users')
  Future<BaseResponse<UserDetailModel?>> signUp(@Body() SignUpRequestModel params);
}
