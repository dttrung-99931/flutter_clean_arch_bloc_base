import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/config/di/injection.dart';
import 'package:maingames_flutter_test/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/features/auth/data/models/request/login_request_model.dart';
import 'package:maingames_flutter_test/features/auth/data/models/response/login_model.dart';
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
    test('Should return correct LoginResponse when dio returns success', () async {
      final LoginRequestModel request = LoginRequestModel(
        email: 'test@gmail.com',
        password: 'aa123456',
      );
      final mockResponseJosn = jsonDecode(succesfulLoginJson);
      final mockResponse = ResponseBody.fromString(
        succesfulLoginJson,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
      when(httpAdapter.fetch(any, any, any)).thenAnswer(
        (_) async => mockResponse,
      );

      final BaseResponse<LoginModel?> response = await authDataSource.login(request);
      expect(response.success, true);
      expect(response.data?.token, mockResponseJosn['data']['token']);
      expect(response.data?.userID, mockResponseJosn['data']['userID']);
      expect(response.data?.cartId, mockResponseJosn['data']['cartId']);
    });

    test('Should return correct Failure when dio returns error', () async {
      final LoginRequestModel request = LoginRequestModel(
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

      final BaseResponse<LoginModel?> dtsResponse = await authDataSource.login(request);
      expect(dtsResponse.success, false);
      expect(dtsResponse.statusCode, 401);
      expect(dtsResponse.data, null);
    });

    test('Should throw DioException when dio returns server error', () async {
      final LoginRequestModel request = LoginRequestModel(
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

    test('Should throw DioException when dio returns unexpected json response', () async {
      final LoginRequestModel request = LoginRequestModel(
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
  });
}
