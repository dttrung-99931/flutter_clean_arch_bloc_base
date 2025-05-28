import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/failures/failures.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/core/utils/network/network_info.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/repositories/auth_repo.dart';
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
    test('Login success', () async {
      final LoginRequestDto request = LoginRequestDto(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponse = BaseResponse<LoginResponseDto?>(
        LoginResponseDto(
          token: 'token',
          userID: 123,
          cartId: 321,
        ),
        true,
        200,
        null,
      );
      when(mockAuthDatasource.login(request)).thenAnswer(
        (_) async => mockResponse,
      );
      final Either<Failure, LoginResponseDto> dtsResponse = await authRepo.login(request);
      expect(dtsResponse.isRight(), true);
      dtsResponse.fold(
        (l) => null,
        (r) {
          expect(r.token, mockResponse.data?.token);
          expect(r.userID, mockResponse.data?.userID);
          expect(r.cartId, mockResponse.data?.cartId);
        },
      );
    });

    test('Login failed', () async {
      final LoginRequestDto request = LoginRequestDto(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockFailedLogin = BaseResponse<LoginResponseDto?>(
        null,
        false,
        401,
        'Unauthorized',
      );
      when(mockAuthDatasource.login(request)).thenAnswer(
        (_) async => mockFailedLogin,
      );
      final Either<Failure, LoginResponseDto> dtsResponse = await authRepo.login(request);
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

    test('Login network error', () async {
      getIt.registerTestDependecy<NetworkInfo>(MockNetworkInfo(isConnectedMock: false));
      final LoginRequestDto request = LoginRequestDto(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponse = BaseResponse<LoginResponseDto?>(
        LoginResponseDto(
          token: 'token',
          userID: 123,
          cartId: 321,
        ),
        true,
        200,
        null,
      );
      when(mockAuthDatasource.login(request)).thenAnswer(
        (_) async => mockResponse,
      );
      final Either<Failure, LoginResponseDto> dtsResponse = await authRepo.login(request);
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
