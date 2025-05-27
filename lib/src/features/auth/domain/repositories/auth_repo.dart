import 'package:dartz/dartz.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/repository/base_repository.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';

abstract class AuthRepo extends BaseRepo {
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto param);
}
