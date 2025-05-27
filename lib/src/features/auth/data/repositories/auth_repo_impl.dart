import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/request/login_request_model.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/request/sign_up_request_model.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/response/login_response_model.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/response/user_detail_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_remote_data_soruce.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthRepoteDatasource datasource;

  AuthRepoImpl(this.datasource);

  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel param) async {
    return handleNetwork(onRemote: handleServerErrors(datasourceResponse: datasource.login(param)));
  }

  @override
  Future<Either<Failure, UserDetailModel>> signUp(SignUpRequestModel param) {
    return handleNetwork(onRemote: handleServerErrors(datasourceResponse: datasource.signUp(param)));
  }
}
