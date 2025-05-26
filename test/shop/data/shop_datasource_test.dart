import 'package:dio/dio.dart';
import 'package:base_project/src/config/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../common/base_setup.dart';
import '../../common/mock_dio_adapter.dart';
import '../../product/data/product_datasource_test.mocks.dart';

@GenerateMocks([DioAdapter])
void main() {
  DioAdapter httpAdapter = MockDioAdapter();

  setUpAll(() async {
    baseTestSetup();
    getIt<Dio>().httpClientAdapter = httpAdapter;
  });

  // group('Test shop datasource', () {
  //   test('', () {
  //     final RequestOptions options = RequestOptions(
  //       method: 'GET',
  //       path: '',
  //     );
  //     // when(httpAdapter.fetch(options, requestStream, cancelFuture))
  //   });
  // });
}
