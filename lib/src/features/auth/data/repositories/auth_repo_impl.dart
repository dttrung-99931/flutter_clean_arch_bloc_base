import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';

import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_data_source.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthDatasource datasource;

  AuthRepoImpl(this.datasource);

  @override
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto param) async {
    return handleNetwork(
      onRemote: handleServerErrors(
        datasourceResponse: datasource.login(param),
      ),
    );
  }
}
