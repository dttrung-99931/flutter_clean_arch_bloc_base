import 'package:dartz/dartz.dart';
import 'package:flutter_base_app/core/failures/failures.dart';
import 'package:flutter_base_app/core/repositories/base_repository.dart';
import 'package:flutter_base_app/features/auth/domain/entities/request/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/response/login_response.dart';

abstract class AuthRepo extends BaseRepo {
  Future<Either<Failure, LoginResponse>> login(LoginRequest param);
}
