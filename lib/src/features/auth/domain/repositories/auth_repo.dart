import 'package:base_project/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:base_project/core/repository/base_repository.dart';
import 'package:base_project/src/features/auth/data/models/request/login_request_model.dart';
import 'package:base_project/src/features/auth/data/models/request/sign_up_request_model.dart';
import 'package:base_project/src/features/auth/data/models/response/login_response_model.dart';
import 'package:base_project/src/features/auth/data/models/response/user_detail_model.dart';

abstract class AuthRepo extends BaseRepo {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel param);
  Future<Either<Failure, UserDetailModel>> signUp(SignUpRequestModel param);
}
