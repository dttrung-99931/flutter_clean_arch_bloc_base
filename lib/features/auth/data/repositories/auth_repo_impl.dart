import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base_app/core/failures/failures.dart';
import 'package:flutter_base_app/core/utils/extensions/common_extension.dart';
import 'package:flutter_base_app/features/auth/data/models/request/login_request_model.dart';
import 'package:flutter_base_app/features/auth/data/models/response/login_model.dart';
import 'package:flutter_base_app/features/auth/domain/entities/request/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/response/login_response.dart';

import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_data_source.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthDatasource datasource;

  AuthRepoImpl(this.datasource);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest param) async {
    return handleNetwork(
      onRemote: handleServerErrors(
        datasourceResponse: datasource.login(LoginRequestModel.fromEntity(param)),
      ),
    ).thenMap((LoginModel model) => model.toEntity());
  }
}
