// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_renaming_method_parameters
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base_app/core/failures/failures.dart';
import 'package:flutter_base_app/core/use_cases/use_case.dart';
import 'package:flutter_base_app/core/utils/storage.dart';
import 'package:flutter_base_app/features/auth/domain/entities/request/login_request.dart';
import 'package:flutter_base_app/features/auth/domain/entities/response/login_response.dart';
import 'package:flutter_base_app/features/auth/domain/repositories/auth_repo.dart';

class LoginParams {
  final LoginRequest request;
  final bool rememberEmail;

  LoginParams({required this.request, required this.rememberEmail});
}

@lazySingleton
class EmailLoginUseCase extends EitherUseCase<LoginResponse?, LoginParams> {
  final AuthRepo _repo;
  final Storage _storage;

  EmailLoginUseCase(this._repo, this._storage);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams loginParam) async {
    return handleRepoResult(
      repoResult: _repo.login(loginParam.request),
      nextRepoResult: (LoginResponse response) {
        return onLoginSuccess(response, loginParam: loginParam);
      },
      onError: (Failure failure) async {
        return failure;
      },
    );
  }

  // Save token, user profile
  Future<Either<Failure, LoginResponse>> onLoginSuccess(
    LoginResponse response, {
    LoginParams? loginParam,
  }) async {
    await _storage.saveToken(response.token);
    return Right(response);

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
