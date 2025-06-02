import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/models/base_response.dart';
import 'package:maingames_flutter_test/core/utils/network/network_info.dart';
import 'package:maingames_flutter_test/config/di/injection.dart';
import 'package:maingames_flutter_test/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/features/auth/data/models/request/login_request_model.dart';
import 'package:maingames_flutter_test/features/auth/data/models/response/login_model.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/request/login_request.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/response/login_response.dart';
import 'package:maingames_flutter_test/features/auth/domain/repositories/auth_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../common/base_setup.dart';
import '../../../common/mock_network_info.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthDatasource])
void main() {
  late MockAuthDatasource mockAuthDatasource;
  late AuthRepo authRepo;

  setUpAll(() async {
    await baseTestSetup();
    getIt.registerTestDependecy<NetworkInfo>(MockNetworkInfo(isConnectedMock: true));
    getIt.registerTestDependecy<AuthDatasource>(MockAuthDatasource());
    mockAuthDatasource = getIt<AuthDatasource>() as MockAuthDatasource;
    authRepo = getIt();
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Test auth repository', () {
    test('Should return correct LoginResponse when datasource call success', () async {
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponse = BaseResponse<LoginModel?>(
        LoginModel(
          token: 'token',
          userID: 123,
          cartId: 321,
        ),
        true,
        200,
        null,
      );
      when(mockAuthDatasource.login(any)).thenAnswer(
        (_) async => mockResponse,
      );
      final Either<Failure, LoginResponse> response = await authRepo.login(request);
      expect(response.isRight(), true);
      verify(mockAuthDatasource.login(any)).called(1);
      response.fold(
        (l) => null,
        (r) {
          expect(r.token, mockResponse.data?.token);
        },
      );
    });

    test('Should return correct Failure when datasource call failed', () async {
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockFailedLogin = BaseResponse<LoginModel?>(
        null,
        false,
        401,
        'Unauthorized',
      );
      when(mockAuthDatasource.login(any)).thenAnswer(
        (_) async => mockFailedLogin,
      );
      final Either<Failure, LoginResponse> dtsResponse = await authRepo.login(request);
      expect(dtsResponse.isLeft(), true);
      dtsResponse.fold(
        (Failure l) {
          expect(l, isA<ServerError>());
          final serverError = l as ServerError;
          expect(serverError.statusCode, mockFailedLogin.statusCode);
          expect(serverError.msg, mockFailedLogin.message);
        },
        (r) {},
      );
    });

    // test('Login server error', () async {
    //   final LoginRequestDto request = LoginRequestDto(
    //     email: 'test@gmail.com',
    //     password: 'aa123456',
    //   );
    //   final jsonError = jsonDecode(internalErrorJson);
    //   when(mockAuthDatasource.login(any)).thenThrow(
    //     DioException(
    //       response: Response(
    //         data: jsonError,
    //         statusCode: 500,
    //         requestOptions: RequestOptions(),
    //       ),
    //       requestOptions: RequestOptions(),
    //     ),
    //   );
    //   final Either<Failure, LoginResponseDto> dtsResponse = await authRepo.login(request);
    //   expect(dtsResponse.isLeft(), true);
    //   dtsResponse.fold(
    //     (l) {
    //       expect(l, isA<ServerError>());
    //       final serverError = l as ServerError;
    //       expect(serverError.statusCode, 500);
    //       expect(serverError.msg, jsonError['message']);
    //     },
    //     (r) {},
    //   );
    // });

    test('Should return correct Failure when datasource call network error', () async {
      getIt.registerTestDependecy<NetworkInfo>(MockNetworkInfo(isConnectedMock: false));
      final LoginRequest request = LoginRequest(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponse = BaseResponse<LoginModel?>(
        LoginModel(
          token: 'token',
          userID: 123,
          cartId: 321,
        ),
        true,
        200,
        null,
      );
      when(mockAuthDatasource.login(LoginRequestModel.fromEntity(request))).thenAnswer(
        (_) async => mockResponse,
      );
      final Either<Failure, LoginResponse> dtsResponse = await authRepo.login(request);
      expect(dtsResponse.isLeft(), true);
      dtsResponse.fold(
        (l) {
          expect(l, isA<NetworkFailure>());
        },
        (r) {},
      );
    });
  });
}
