import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/config/di/injection.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/request/login_request.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/response/login_response.dart';
import 'package:maingames_flutter_test/features/auth/domain/repositories/auth_repo.dart';
import 'package:maingames_flutter_test/features/auth/domain/use_cases/login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../common/base_setup.dart';
import 'auth_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;

  late EmailLoginUseCase loginUseCase;

  setUpAll(() async {
    await baseTestSetup();
    getIt.registerTestDependecy<AuthRepo>(MockAuthRepo());
    mockAuthRepo = getIt<AuthRepo>() as MockAuthRepo;
    loginUseCase = getIt();
  });

  tearDown(() {
    getIt<Storage>().deleteAll();
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Test auth use cases', () {
    test('Should return correct LoginResponse when repository call successs', () async {
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponse = LoginResponse(token: 'token');
      when(mockAuthRepo.login(request)).thenAnswer(
        (_) async => Right(mockResponse),
      );
      final Either<Failure, LoginResponse> result = await loginUseCase.call(
        LoginParams(request: request, rememberEmail: false),
      );
      expect(result.isRight(), true);
      result.fold(
        (l) => null,
        (LoginResponse r) {
          expect(r.token, mockResponse.token);
          final storage = getIt<Storage>();
          expect(storage.token, mockResponse.token);
        },
      );
    });

    test('Should return Failure(ServerError) when repository call failed', () async {
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockAPIError = ServerError(msg: 'Login failed', statusCode: 401);
      when(mockAuthRepo.login(request)).thenAnswer(
        (_) async => Left(mockAPIError),
      );
      final Either<Failure, LoginResponse> result = await loginUseCase.call(
        LoginParams(request: request, rememberEmail: false),
      );
      expect(result.isLeft(), true);
      result.fold(
        (l) {
          expect(l, isA<ServerError>());
          final serverError = l as ServerError;
          expect(serverError.statusCode, mockAPIError.statusCode);
          expect(serverError.msg, mockAPIError.msg);
          expect(getIt<Storage>().token, null);
        },
        (r) {},
      );
    });

    test('Should return Failure(NetworkFailure) when repository call network error', () async {
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockNetworkError = NetworkFailure();
      when(mockAuthRepo.login(request)).thenAnswer(
        (_) async => Left(mockNetworkError),
      );
      final Either<Failure, LoginResponse> result = await loginUseCase.call(
        LoginParams(request: request, rememberEmail: false),
      );
      expect(result.isLeft(), true);
      result.fold(
        (l) {
          expect(l, isA<NetworkFailure>());
          expect(getIt<Storage>().token, null);
        },
        (r) {},
      );
    });
  });
}
