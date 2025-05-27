// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_renaming_method_parameters
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/use_case/use_case.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/models/login_response_model.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/repositories/auth_repo.dart';

import '../../data/dtos/response/login_response_dto.dart';

class LoginParams {
  final LoginRequestDto requestModel;
  final bool rememberEmail;

  LoginParams({required this.requestModel, required this.rememberEmail});
}

@lazySingleton
class EmailLoginUseCase extends EitherUseCase<LoginResponseModel?, LoginParams> {
  final AuthRepo _repo;
  final Storage _storage;

  EmailLoginUseCase(this._repo, this._storage);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginParams loginParam) async {
    return handleRepoResult(
      repoResult: _repo.login(loginParam.requestModel),
      nextRepoResult: (LoginResponseDto loginResponse) {
        return onLoginSuccess(loginResponse, loginParam: loginParam);
      },
      onError: (Failure failure) async {
        return failure;
      },
    );
  }

  // Save token, user profile
  Future<Either<Failure, LoginResponseModel>> onLoginSuccess(
    LoginResponseDto loginResponse, {
    LoginParams? loginParam,
  }) async {
    await _storage.saveToken(loginResponse.token);
    return Right(LoginResponseModel.fromDto(loginResponse));

    // TODO: handle get profile
    // return await handleRepoResult<LoginResponseDto, UserProfileModel>(
    //   repoResult: _repo.getProfile(),
    //   onSuccess: (UserProfileModel profile) async {
    //     await Future.wait([
    //       _storage.saveUserProfile(profile),
    //       if (loginParam != null)
    //         loginParam.rememberEmail
    //             ? _storage.saveLoginEmail(loginParam.requestModel.email)
    //             : _storage.deleteLoginEmail()
    //     ]);
    //     return LoginResponseDto.fromModel(loginResponse);
    //   },
    //   onError: (failure) async {
    //     _storage.deleteToken();
    //     return failure;
    //   },
    // );
  }
}
