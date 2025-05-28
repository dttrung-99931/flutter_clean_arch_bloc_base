import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../common/base_setup.dart';
import '../../../common/base_setup.mocks.dart';
import '../../../common/mock_dio_adapter.dart';
import 'mock_response_json.dart';

@GenerateMocks([DioAdapter])
void main() {
  final MockDioAdapter httpAdapter = MockDioAdapter();
  late AuthDatasource authDataSource;

  setUpAll(() async {
    await baseTestSetup();
    getIt<Dio>().httpClientAdapter = httpAdapter;
    authDataSource = getIt();
  });

  tearDownAll(() {
    getIt.resetLazySingleton<Dio>();
  });

  group('Test auth datasource', () {
    test('Login success', () async {
      final LoginRequestDto request = LoginRequestDto(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponseJosn = jsonDecode(succesfulLoginJson);
      final response = ResponseBody.fromString(
        succesfulLoginJson,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(httpAdapter.fetch(any, any, any)).thenAnswer(
        (_) async => response,
      );

      final BaseResponse<LoginResponseDto?> dtsResponse = await authDataSource.login(request);
      expect(dtsResponse.success, true);
      expect(dtsResponse.data?.token, mockResponseJosn['data']['token']);
      expect(dtsResponse.data?.userID, mockResponseJosn['data']['userID']);
      expect(dtsResponse.data?.cartId, mockResponseJosn['data']['cartId']);
    });
  });

  test('Login failed', () async {
    final LoginRequestDto request = LoginRequestDto(
      email: 'test@gmail.com',
      password: 'aa123456',
    );
    final response = ResponseBody.fromString(
      failedLoginJson,
      401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
    when(httpAdapter.fetch(any, any, any)).thenAnswer(
      (_) async => response,
    );

    final BaseResponse<LoginResponseDto?> dtsResponse = await authDataSource.login(request);
    expect(dtsResponse.success, false);
    expect(dtsResponse.statusCode, 401);
    expect(dtsResponse.data, null);
  });

  test('Login server error', () async {
    final LoginRequestDto request = LoginRequestDto(
      email: 'test@gmail.com',
      password: 'aa123456',
    );
    final response = ResponseBody.fromString(
      serverErrorHtml,
      500,
      headers: {
        Headers.contentTypeHeader: [Headers.textPlainContentType],
      },
    );
    when(httpAdapter.fetch(any, any, any)).thenAnswer(
      (_) async => response,
    );

    expect(
      () async => authDataSource.login(request),
      throwsA(
        predicate((e) => e is DioException && e.response?.statusCode == 500),
      ),
    );
  });

  test('Login unxpected json response', () async {
    final LoginRequestDto request = LoginRequestDto(
      email: 'test@gmail.com',
      password: 'aa123456',
    );
    final response = ResponseBody.fromString(
      unexpectedJsonResponse,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.textPlainContentType],
      },
    );
    when(httpAdapter.fetch(any, any, any)).thenAnswer(
      (_) async => response,
    );

    expect(
      () async => authDataSource.login(request),
      throwsA(
        predicate((e) => e is DioException),
      ),
    );
  });
}
