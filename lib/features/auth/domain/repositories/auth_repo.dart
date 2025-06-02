import 'package:dartz/dartz.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/repository/base_repository.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/request/login_request.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/response/login_response.dart';

abstract class AuthRepo extends BaseRepo {
  Future<Either<Failure, LoginResponse>> login(LoginRequest param);
}
